Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED844C9C02
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 04:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiCBDVd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 22:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiCBDVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 22:21:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C25B0A51
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 19:20:49 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2221cla7010815;
        Tue, 1 Mar 2022 19:20:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=spstcbRkWPrmSrOk/GGpG9Gp7tcuXlVyjnm3xa4UYVI=;
 b=eM+Fw5MKxzmKYpXD5jJWJhH31yGDTE0ho0ecjCJ2zub0C6qcCrVbtSEelRCMt7MDnrvX
 zFckdxfxvfZQLVCWDAoaA9VUKIJfartpAWlXP2Q2vTHh2pIulX8jXRTZEskRSUBO/pS7
 DaofKx7Gx+mi7zuCtLXKMXfJeuwZs1J6kjY= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ehgh4xrf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 19:20:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3My50aOKREyjfkKVeWSaDuAjIoVVh0JURrmedpUCE9/geVnDxdHOo3/8SH9VmRkeO/5jxJ5zlfr8iarecMee65euFmOl00gebeyAGZf0heZ3q1vvGM5+wjEyqAoOqHyhyuQ5M3fP2VW/PwvIYeR4YYLK3NXsgccZ4JfUmdTbEJ+fERQ/2AxXjY1E9HZVWEkvihXW9UN9C5upZA57iCgZBgFlDwUs8NgOuDkvxEaMC1al+pZCI7KhbDkHS4EJXgYJOrfWLLgWbN2jADP0DPJMUK5dIfIskUhTNmiKb5w2f3GWBeTBCs4rG7IXh0jEvjz5bnBDfO/pn4ZUefTggwEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spstcbRkWPrmSrOk/GGpG9Gp7tcuXlVyjnm3xa4UYVI=;
 b=gL8A2P1rYshF8kVV5EhcFcExoMj4bAvZjMKxh3nd5L9/cNWWSzA7G7FvmpTeoHXQs5hVXKLIS8PM5dGUFUCHsJyiBdsGRnC4Ezy3PQiJ0oeXXeCK1yhOFdspVoA8BZWfAOMZK67FNk0J9/gwSqr+c9ee2YMBS1jfOhYvTB8yenJYAxFw2MN3LuMrdOchuf8WVrt/tF79v7iWa1Aa5lW+Oq0LPZNZseFTF6lzUDbuA/ub5/K6AToUfGlEFb8BFED0QIG/b/92ARAnGXO3/ukEllFAhhdp3zeS1/pXp7nI0OgVGnjL19iYmX24NPdz7aVMAUCC7uhHRH4D+lae5KWN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BY3PR15MB4867.namprd15.prod.outlook.com (2603:10b6:a03:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 03:20:29 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 03:20:28 +0000
Date:   Tue, 1 Mar 2022 19:20:24 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301065745.1634848-5-memxor@gmail.com>
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15e85e7-9dd0-4aae-cc23-08d9fbfb99e0
X-MS-TrafficTypeDiagnostic: BY3PR15MB4867:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB48678D64AE55DFF30EA5F941D5039@BY3PR15MB4867.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YwC0RP+YOdZrtz2WnMjKvlh5fYIPD+pa6ZfgXw9Dk5XE6H9gTd6oDlZPYIxUX6GCD0erRCkdwCrxXwPCNH+GedAKxIDr9ybsvf3R4nKaAMOCgOgZlDVAKDQu72zVQlI7inqnz7E8xeXxoe/ck8UEISvOMdx6cwNF89LA4M0h6rjHR0IbNN+vz7dVh2a7TpPgoLwTMcU65zEEPpmg7GhyJ6SP0V/LLULWsFBihwQQLeppWnjE1uuJA8ZSLjbQVpharD4iQVyfH/x8V3cQk4smEXJFkyAi59GNIOZH5EPExlYt10I19wciEzZzmp7PpAu48z5ATzdyTK2hOn+TMv1FsRxh6dJwnNf1o45KuoMp1Imgtii63b51Lvz2ZEPfg85KKy8q/9pzy6JCOxZiE0X1aZAf/yNzvAjGKsQLs5TbiOBQFG3XklykATOP9Vxq+SdxKxSUe2w4MoSG9g4Mk3evKGRXq3fxWTi7hH7FyNmT6BXPxf7EoNIhya8UlmEN2+dteSwRT1WjlMx6EDNgHSGL/l6nJS8vJsYKEv8M5Z6UW0LPV8H6hhifdkWQfJquVkN2r+hRXLpkciSUY/uykoao1kpeJddzTCD0NAETii9Ao3JUpL6uWDike1KkUEEklo6zJIWPa19JZ5bljtrCuI6pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(6506007)(186003)(2906002)(6512007)(9686003)(83380400001)(5660300002)(1076003)(66556008)(66476007)(66946007)(4326008)(8676002)(6486002)(508600001)(38100700002)(86362001)(54906003)(6916009)(316002)(33716001)(6666004)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQqggNYztbnDxZ2hl7EZi7GLhVkhA5WNOdqY7BtAeE1YReExtl562kAisOHx?=
 =?us-ascii?Q?vA5CqkIST6bdig5zQFMsPbccH+f58Cakz/R85nrmGyfQi6aSeAlx0neM//lY?=
 =?us-ascii?Q?/bEwP8368rkhTNo5XNOeZuL6w34MqgsfNbpmicgNKJiphKzHcd7wNbKBsDWA?=
 =?us-ascii?Q?lLezLRT+IezZGrBUuE5AdlAFNIuxw+MjXW78hg2luXwBdC8GflH7TeoTzIa5?=
 =?us-ascii?Q?6VydCntY+oGp68IYuZzj/xz9FMeEiyawmyWE8kNP6+gOSwJYfI44gBErPrRx?=
 =?us-ascii?Q?Amg31x76j5EqgzSY0wW6NKh4It6Eet+tRuQbqRQvqHOX2DEvfROUpyNWWO8X?=
 =?us-ascii?Q?D2Ua3nk1im1RvFuawgMOK1AIclbz1svqhAJPFGClEuZ+E76OZ354+i/UMBBQ?=
 =?us-ascii?Q?KuT1hXvJO6VzGJXePM55BfOomuh2YproUHJPZqSr7sEyY7ItdORMYmtF4bwO?=
 =?us-ascii?Q?wYEmM5LJYt20/0d0GpWzSZj4MaZZNY9rDdAaH2WDes9wtP9Qs++m4OFMQwhe?=
 =?us-ascii?Q?Q6Vy1oURFwwPMAD+O2x+XAfT7JQbJeqwX+rNm1UkpX+kLcCTJrM1/ypkH3i0?=
 =?us-ascii?Q?RLqEw845udB5IrATi+SGhQ23HQjuQMxiOJA+hgb+3w0/ti1kloN46//h35kW?=
 =?us-ascii?Q?bfLo9lNLXZ7mEecOu5G8sgGb40mcy13JzaGgrtu+6Af+NYZcxLDOgrPkInPY?=
 =?us-ascii?Q?NCcdTEyuWIC05dfaxd46I8AC6f9IvWVY+vVpvztABGBq0bmcYHZOApzYiP57?=
 =?us-ascii?Q?tGwDEt+vxTht0ld5u9tGTKiXXdiXxxbqxSjD7XjBjlu6dMoCczjEj5k5l3hd?=
 =?us-ascii?Q?SP9JpQ6Owx8PXRPCP7YisBPfoIH2oCMS1dAAEDVzBw42zEE8DfnEjLT4/saD?=
 =?us-ascii?Q?amPTuHY7ODIhWss0Sg478nKwtY0nxXUsTHlJghSy+rVak83RQJZ6UKL1GZgx?=
 =?us-ascii?Q?+ZaJVrz2KBXCnwnUFRbt9f/CWapjGvJ3n9mgyPGkWSniF3FGadgvJUfoZKy0?=
 =?us-ascii?Q?ZIglY7a3JJNHEj04I8lSYS2C0Vg/0LEOj3H0OgQk1TXd7+PQZ2rEGW7gE+76?=
 =?us-ascii?Q?fHwWguTgYmDU+VE38ZoM72ky76gRbtfaTdjDA8fSUyOw4jYIIq3DkBTKR1pD?=
 =?us-ascii?Q?kSH6I6JAciKOU3NPZMxUcfNRxfis33lGX1BdDUaOHB5Q62HXpsvcoBlRc8rv?=
 =?us-ascii?Q?xAO02uyatvXleAF67fo2o4noXuMYNt5K5E+ghMPDK0Wu1emWy3WCbKgNfT3F?=
 =?us-ascii?Q?U/dL0pL+Pge9ej53nEhBdR6p4R7EDkM6E6KYYytq2FMUzN8lDJS6ajj4tqzw?=
 =?us-ascii?Q?1RYlOAGv0lf7qanOF3wDVY4+5jw6KgZrHIKOQrOrDLHLkojq9Tl8CTbzyVeN?=
 =?us-ascii?Q?PW6DwlFdbJrxXyIckUlLUN06DzgqL3eXC8BWC3PwfnRUGvNsupNcWcCvwTs+?=
 =?us-ascii?Q?6tkGrvmnOayzN32dFweElKFAjT5uHndzHnKFKENTLewuJrLvI+eJET8aDDDm?=
 =?us-ascii?Q?PmcOyN3Wb/eMAwz9yRDk+rqJpqCowfvjBiv0+Py/+w9J4tszR7OZ80SxHhCr?=
 =?us-ascii?Q?7D/H7/VL3VJ6/UveojIaLVlzWzc/oAKNOi2/dgBx?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15e85e7-9dd0-4aae-cc23-08d9fbfb99e0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:20:28.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RvRDWdQCG49j0pXFkxBKdae3KkmWdrfFHOzFw9sVf28aXdztDT0mO1wA8zDRNyM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4867
X-Proofpoint-ORIG-GUID: 5eMt9Sww6iX8fwYYE18GjZClcLf8PEpg
X-Proofpoint-GUID: 5eMt9Sww6iX8fwYYE18GjZClcLf8PEpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020013
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 01, 2022 at 12:27:43PM +0530, Kumar Kartikeya Dwivedi wrote:
> Let's ensure that the PTR_TO_BTF_ID reg being passed in to release kfunc
> always has its offset set to 0. While not a real problem now, there's a
> very real possibility this will become a problem when more and more
> kfuncs are exposed.
> 
> Previous commits already protected against non-zero var_off. The case we
> are concerned about now is when we have a type that can be returned by
> acquire kfunc:
> 
> struct foo {
> 	int a;
> 	int b;
> 	struct bar b;
> };
> 
> ... and struct bar is also a type that can be returned by another
> acquire kfunc.
> 
> Then, doing the following sequence:
> 
> 	struct foo *f = bpf_get_foo(); // acquire kfunc
> 	if (!f)
> 		return 0;
> 	bpf_put_bar(&f->b); // release kfunc
> 
> ... would work with the current code, since the btf_struct_ids_match
> takes reg->off into account for matching pointer type with release kfunc
> argument type, but would obviously be incorrect, and most likely lead to
> a kernel crash. A test has been included later to prevent regressions in
> this area.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/btf.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7f6a0ae5028b..ba6845225b65 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> +	if (is_kfunc)
> +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> +						BTF_KFUNC_TYPE_RELEASE, func_id);
>  	/* check that BTF function arguments match actual types that the
>  	 * verifier sees.
>  	 */
> @@ -5816,6 +5819,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  							regno, reg->ref_obj_id, ref_obj_id);
>  						return -EFAULT;
>  					}
> +					/* Ensure that offset of referenced PTR_TO_BTF_ID is
> +					 * always zero, when passed to release function.
> +					 * var_off has already been checked to be 0 by
> +					 * check_func_arg_reg_off.
> +					 */
> +					if (rel && reg->off) {
Here is another reg->off check for PTR_TO_BTF_ID on top of the
one 'check_func_arg_reg_off' added to the same function in patch 2.
A nit, I also found passing ARG_DONTCARE in patch 2 a bit convoluted
considering the btf func does not need ARG_* to begin with.

How about directly use the __check_ptr_off_reg() here instead of
check_func_arg_reg_off()?  Then patch 1 is not needed.

Would something like this do the same thing (uncompiled code) ?

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7f6a0ae5028b..768cef4de4cc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5794,6 +5797,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			}
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
 			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
+			bool fixed_off_ok = reg->type == PTR_TO_BTF_ID;
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -5816,6 +5820,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 							regno, reg->ref_obj_id, ref_obj_id);
 						return -EFAULT;
 					}
+					/* Ensure that offset of referenced PTR_TO_BTF_ID is
+					 * always zero, when passed to release function.
+					 * var_off has already been checked to be 0 by
+					 * check_func_arg_reg_off.
+					 */
+					if (rel)
+						fixed_off_ok = false;
 					ref_regno = regno;
 					ref_obj_id = reg->ref_obj_id;
 				}
@@ -5824,6 +5835,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
 			}
 
+			__check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
 							    &reg_ref_id);
 			reg_ref_tname = btf_name_by_offset(reg_btf,

