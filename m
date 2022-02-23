Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E394C0674
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 01:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiBWA4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 19:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWA4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 19:56:07 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5AA42494
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 16:55:40 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MNkEFm015486
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 16:55:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=MRzOruXJQINMtlsUrSplvXGpOzsgt5yrLJJiLNVz41c=;
 b=IlQO3kTemGJrrZM3ltS6wkgbv1O7YaSKTxLUUUbVCmqDi6iCb7trUqySqKCJqt56GRSr
 1cosXK7RENzAHKNehEQn4zMALq9K/XabVB63oaPOD0HqJayFV/qtMp8HUUQy1RW+gfiX
 uV+ixksVp9SaEJmz+jNcVnY5FwiUAEg0iek= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ecdye9kmw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 16:55:39 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 16:55:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI2KKUdOpHAwxcqcEvEW9ekZHrfIIJKOUOnm5PV83c61VFuTlN3fxzmNa3NrlpxDJ6wf768jc6JRyZsm9gohqNxAgvCV9K+AJ//rYBHjpjmygGCx00Mzk8rDKGaN6eekk5f8SraqCfrII5L+b6uJ27wFW5h8TxEhjE4MTUkjY6B9IociEQR+VBgmi97vj/hJSVOvTq6yxzJIXBbfePZrW5GqrHYHsJ4NMOQc34frREmoh4Icp/E4XRlRVpBkF6Mhu2S4f+KAXjLy0yHKC0Ud+M6L4+GtFLwZZ1Bk21aegKRcGXDm6deP2sCX6aLYxi4sPPMfc+mixDPKBTFZCQLrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRzOruXJQINMtlsUrSplvXGpOzsgt5yrLJJiLNVz41c=;
 b=aIR8idikHyMXRKCWggs7CtdUN+2CHpDVn1N4V5eE6x0DrU0Fv2+WzwIFJalv1fC4YhyOUV7j9XWaQ+j2nItO0scJY+9AfyP7xTViEXmULNnGqrnbucVXrcstUY+DWg2RbZ0qI0fDOjdj06eHcb+nv3gFiNHAiS+IUEWtntiEj7hQX+ZzTVmfKExIgdS91NHHqJacxY9U7X0g+IZBlqGwOa8Aoo3z1g2uHZ8vWgZ8XfLkwkGnckusqrYHKdImJInNeznBula+4oAUq7zlNK3mFtt5EiBGD+Yace36t99ywnp7pKUvS0ZeI81Luczudy6hPSgnPSqOZh1uSTBYj6K8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by MWHPR15MB1808.namprd15.prod.outlook.com (2603:10b6:301:51::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 23 Feb
 2022 00:55:35 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::79fb:4741:b90a:e871]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::79fb:4741:b90a:e871%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 00:55:35 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
CC:     Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH v2 bpf-next] Small BPF verifier log improvements
Thread-Topic: [PATCH v2 bpf-next] Small BPF verifier log improvements
Thread-Index: AQHYKCKSi4fJIWueAECSrSRIcsGIDKygT9sA
Date:   Wed, 23 Feb 2022 00:55:34 +0000
Message-ID: <9201EAEE-BFB6-49D2-B8EF-112B0CB22806@fb.com>
References: <20220222192944.3618929-1-mykolal@fb.com>
In-Reply-To: <20220222192944.3618929-1-mykolal@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d32f5b1f-a1d0-4482-9166-08d9f667333a
x-ms-traffictypediagnostic: MWHPR15MB1808:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1808084B61DAFB56C6DBE501C03C9@MWHPR15MB1808.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xBMAR7nqMUCXD37J2Z/TXlQEmG4KZBD3msSHfPKK0+CF6x52LdAvDTSvcB4I85i0YcS+r93HK/I/0/wCeqv9Ei/42qXJ9OvWJ+/b6qc2o3eMfmApFKdlFSohBhmZZlW219uCzz3RYpbbazNITZZPIydFO99NcyM/1YhAkvPJgC6QVR0VKJb3xkev77BfH7SQgOqgPxekvJ341kn+uInRDdpH9DPaV8FXMBA2tBLuope3xMnIeYfb5VwIBM+TgSv2w5J14WpYt8BYwznpXJRjk6/ZnoBqT2ArYiHQMFmAvQ3sm52qZp+PyjndzEsj319/zn3PbP4pNcEOz9oQEgcgx0ENDzofviYO98WJXfSdnRnbN3QxjMExC+51Ewfgk4vNjCmQAzauzsub3QCjucLE/UbrC4wWyrQiknAOHa24cdBuL7CSWLu87H0nwzw7EUjGG3oNA49SU2fhHsxUyud4s3mSFSpUKaN4xRFoZgfWR/tYE59h3KypuTDe8MKNA7iLgEuQDNUuzMbBuRIYyFOtXCCv4p9kYZqM9EQVCKEk6VkOk93zswwkNN81BDruFgrvV36ew/mgZIoYtaNSSWu9rZ2ePCzm+p24cV234aBCQ9ePmPmOPZVAhrRBpkUU7UkYrf8MvFQjbXNZf58aPg0Czx8pXP/kqNGWv/wz+ZsB3l6j89ikiOg3Pv7RuLRDNdhHbnM0o0k+y0rpKhzs+mgsy5IQYYfFbiVqx9gPEXrTjrGm2rKTc1MpG+otHYlfIzl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6486002)(2906002)(6506007)(186003)(66446008)(53546011)(2616005)(71200400001)(66946007)(4326008)(86362001)(76116006)(30864003)(508600001)(66556008)(66476007)(38070700005)(64756008)(83380400001)(8936002)(6512007)(33656002)(110136005)(8676002)(38100700002)(122000001)(36756003)(316002)(45980500001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yoqrG010C2jjPvGo6q3SqLCcu5NRf2RlSLIAtlktSgpX5ehqxIPoHJfnZ8Ze?=
 =?us-ascii?Q?o+4OoX1MtLrvwkJWjuMBK7QWAYD40kdQpobyAYxJe9Ito2pgZHSeK/py2cO8?=
 =?us-ascii?Q?HNJyIdfiNHcPt4/eaescfcTruGCXf7nByIY9arNjH7OpV4swt+2G0pan3MuO?=
 =?us-ascii?Q?L3WGvaPu+5B5n4yB5hyN79u7CY5lPSitWoJ7cZql0ngUNTd/m5ER8jQTtTuo?=
 =?us-ascii?Q?UBBVrnndGIOVv9uyNLxECRzNwUlwHtI8kqkW1N02xRmI2tWnF54EDF5IWkSA?=
 =?us-ascii?Q?r0x7BcCmMszGTmfp2DInm9XnHHP6BZVh9g6gOlM7al+Hq4ToDERLM22UPU6W?=
 =?us-ascii?Q?d0/NVhtw2mdSJeMeVP3oXlFM0Nq6I7heQWEYF79gpGsyEcHUnZG1rw3RB/ak?=
 =?us-ascii?Q?GUxPiByAfAakRpBnPSdouZ2Nwf2sNjvKFrwtYzpLI7C5oNo58y9skQHsbsXs?=
 =?us-ascii?Q?tpyLIUpq7JqW3ol7j/qewr6PAW3l7QXbC7v4qWtVq5MsmURtLI9I5dp1Mkod?=
 =?us-ascii?Q?Aw6+M5uBJQvNnCNpSXrceCy9PINDp4wQ4z0dpp38Np60Er8y7TwgySo9+SB/?=
 =?us-ascii?Q?+UknIhAz+eohu8JVmjzNRRkTp9Lx6LC3j1wC/19ljLn2OMF/guMoyyP8BUwE?=
 =?us-ascii?Q?qDIJ9yjbKh7PNuyr7pJYceYD9XQjl7wll7QVv0lP6HAsdmLBYqWZu0piO3Vn?=
 =?us-ascii?Q?4WgQ8btYjfsYQSLlfxm4nPIQBLTj21zr17eVNDNVcuu+DYyuIwPtwUUN5rE5?=
 =?us-ascii?Q?fBCM+lxXjn1fgrNM6b60Sk9vZez8lovCdFWMdDsPbq5iWZIL5qbsHBtkmaX/?=
 =?us-ascii?Q?Uy7ig4HwJwAgMP83kNssG9WClT3y4vKc1ZL99OGXGoVlte66dqN7Vu0dn1T+?=
 =?us-ascii?Q?RgsjR3WA8BqaL+uuDPF/YB/dKzIYd4M8DzvtRRKRW9i/CW+VDHgaFH5llEXJ?=
 =?us-ascii?Q?V6Ztak21Q06BTGy6u6MGJVkuFor4XEn7VFmcx390CwNceroSb1b8lqKSfLP3?=
 =?us-ascii?Q?h3mFmoXU21NgeyP7OUfIGseg9Zyk0jPRiVVlk7EE/b2I2XuEdEpa0Tx6FCDR?=
 =?us-ascii?Q?8Jj7JAof1MJqIzlzprBH33sV+Yto8vEE5Nf5TvmOzaFQtP98bSIRHOg4do/4?=
 =?us-ascii?Q?LAmwpip6bbT856Ee7Vgvknp96zwQjxDMIR1IGS+y41Z6yIeDY/21T0B7mQLK?=
 =?us-ascii?Q?Q3OACKXDmlouJPoLSEgL4DYPMm+AKAAwoXsw9jEttTh00OhkzFZ8pYkvDARU?=
 =?us-ascii?Q?CcmU9czSsC47ExRCsI7wLZ4+gspxkjXoQQMvzs2L9HuPCCP0GQsZAT8VALnP?=
 =?us-ascii?Q?pj9RRNcgXehfVdArVeefe3cs86boXJ2dEjOkSJrOvEXW55BaEIQ3elqZH9fz?=
 =?us-ascii?Q?L0UB2KuggC7cn32Slfv2LjzAEk36uxLOkvyTC0LLafPqkRfZsd6ZAaYZuGxo?=
 =?us-ascii?Q?kQMKPHuZp3QO6nnzBKRcAeB+yqsm3ftW/b2hlBv0aO0/1hmWwXVSQGmAt+sm?=
 =?us-ascii?Q?mwA/uqq4BkYgZ0Hsq+bAS92pc4ogZA2udGENJJzVLLa8A5s/+nUhoW4XL0Vd?=
 =?us-ascii?Q?nH3oTx1xBk+EoRXqTSFY8YvWdr1EsmTgXX7aIFxObO8vrdWkrmOxP9X6dH3H?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DE421623F68DB4DB1F7A8DF8553E390@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32f5b1f-a1d0-4482-9166-08d9f667333a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 00:55:35.0082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoLQSQ9APPH1mjHhLUAiE+88hySrJfW4DhnoftWi9MgKyB4OGBaSFjVxJQx+qSdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1808
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ziYMylJid8RP9W5nxBtUI0OUskzS-HxT
X-Proofpoint-ORIG-GUID: ziYMylJid8RP9W5nxBtUI0OUskzS-HxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_08,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202230000
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 22, 2022, at 11:29 AM, Mykola Lysenko <mykolal@fb.com> wrote:
> 
> In particular:
> 1) remove output of inv for scalars
> 2) remove _value suffixes for umin/umax/s32_min/etc (except map_value)
> 3) remove output of id=0
> 4) remove output of ref_obj_id=0
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---
> kernel/bpf/verifier.c                         |  58 ++---
> .../testing/selftests/bpf/prog_tests/align.c  | 218 +++++++++---------
> .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
> 3 files changed, 142 insertions(+), 138 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d7473fee247c..fe8e279ad6a4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -539,7 +539,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> 	char postfix[16] = {0}, prefix[32] = {0};
> 	static const char * const str[] = {
> 		[NOT_INIT]		= "?",
> -		[SCALAR_VALUE]		= "inv",
> +		[SCALAR_VALUE]		= "",
> 		[PTR_TO_CTX]		= "ctx",
> 		[CONST_PTR_TO_MAP]	= "map_ptr",
> 		[PTR_TO_MAP_VALUE]	= "map_value",
> @@ -693,69 +693,73 @@ static void print_verifier_state(struct bpf_verifier_env *env,
> 			/* reg->off should be 0 for SCALAR_VALUE */
> 			verbose(env, "%lld", reg->var_off.value + reg->off);
> 		} else {
> +			const char *sep = "";
> +
> 			if (base_type(t) == PTR_TO_BTF_ID ||
> 			    base_type(t) == PTR_TO_PERCPU_BTF_ID)
> 				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
> -			verbose(env, "(id=%d", reg->id);
> -			if (reg_type_may_be_refcounted_or_null(t))
> -				verbose(env, ",ref_obj_id=%d", reg->ref_obj_id);
> +
> +			verbose(env, "(");
> +
> +#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__); sep = ","; })

Will add comment what _a stands for

> +
> +			if (reg->id)
> +				verbose_a("id=%d", reg->id);
> +
> +			if (reg_type_may_be_refcounted_or_null(t) && reg->ref_obj_id)
> +				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
> 			if (t != SCALAR_VALUE)
> -				verbose(env, ",off=%d", reg->off);
> +				verbose_a("off=%d", reg->off);
> 			if (type_is_pkt_pointer(t))
> -				verbose(env, ",r=%d", reg->range);
> +				verbose_a("r=%d", reg->range);
> 			else if (base_type(t) == CONST_PTR_TO_MAP ||
> 				 base_type(t) == PTR_TO_MAP_KEY ||
> 				 base_type(t) == PTR_TO_MAP_VALUE)
> -				verbose(env, ",ks=%d,vs=%d",
> -					reg->map_ptr->key_size,
> -					reg->map_ptr->value_size);
> +				verbose_a("ks=%d,vs=%d",
> +					  reg->map_ptr->key_size,
> +					  reg->map_ptr->value_size);
> 			if (tnum_is_const(reg->var_off)) {
> 				/* Typically an immediate SCALAR_VALUE, but
> 				 * could be a pointer whose offset is too big
> 				 * for reg->off
> 				 */
> -				verbose(env, ",imm=%llx", reg->var_off.value);
> +				verbose_a("imm=%llx", reg->var_off.value);
> 			} else {
> 				if (reg->smin_value != reg->umin_value &&
> 				    reg->smin_value != S64_MIN)
> -					verbose(env, ",smin_value=%lld",
> -						(long long)reg->smin_value);
> +					verbose_a("smin=%lld", (long long)reg->smin_value);
> 				if (reg->smax_value != reg->umax_value &&
> 				    reg->smax_value != S64_MAX)
> -					verbose(env, ",smax_value=%lld",
> -						(long long)reg->smax_value);
> +					verbose_a("smax=%lld", (long long)reg->smax_value);
> 				if (reg->umin_value != 0)
> -					verbose(env, ",umin_value=%llu",
> -						(unsigned long long)reg->umin_value);
> +					verbose_a("umin=%llu", (unsigned long long)reg->umin_value);
> 				if (reg->umax_value != U64_MAX)
> -					verbose(env, ",umax_value=%llu",
> -						(unsigned long long)reg->umax_value);
> +					verbose_a("umax=%llu", (unsigned long long)reg->umax_value);
> 				if (!tnum_is_unknown(reg->var_off)) {
> 					char tn_buf[48];
> 
> 					tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -					verbose(env, ",var_off=%s", tn_buf);
> +					verbose_a("var_off=%s", tn_buf);
> 				}
> 				if (reg->s32_min_value != reg->smin_value &&
> 				    reg->s32_min_value != S32_MIN)
> -					verbose(env, ",s32_min_value=%d",
> -						(int)(reg->s32_min_value));
> +					verbose_a("s32_min=%d", (int)(reg->s32_min_value));
> 				if (reg->s32_max_value != reg->smax_value &&
> 				    reg->s32_max_value != S32_MAX)
> -					verbose(env, ",s32_max_value=%d",
> -						(int)(reg->s32_max_value));
> +					verbose_a("s32_max=%d", (int)(reg->s32_max_value));
> 				if (reg->u32_min_value != reg->umin_value &&
> 				    reg->u32_min_value != U32_MIN)
> -					verbose(env, ",u32_min_value=%d",
> -						(int)(reg->u32_min_value));
> +					verbose_a("u32_min=%d", (int)(reg->u32_min_value));
> 				if (reg->u32_max_value != reg->umax_value &&
> 				    reg->u32_max_value != U32_MAX)
> -					verbose(env, ",u32_max_value=%d",
> -						(int)(reg->u32_max_value));
> +					verbose_a("u32_max=%d", (int)(reg->u32_max_value));
> 			}
> 			verbose(env, ")");
> 		}
> 	}
> +
> +#undef verbose_append

This should match a macro definition name, will send a version 3 with a fix

> +
> 	for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> 		char types_buf[BPF_REG_SIZE + 1];
> 		bool valid = false;
> diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
> index 0ee29e11eaee..210dc6b4a169 100644
> --- a/tools/testing/selftests/bpf/prog_tests/align.c
> +++ b/tools/testing/selftests/bpf/prog_tests/align.c
> @@ -39,13 +39,13 @@ static struct bpf_align_test tests[] = {
> 		},
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.matches = {
> -			{0, "R1=ctx(id=0,off=0,imm=0)"},
> +			{0, "R1=ctx(off=0,imm=0)"},
> 			{0, "R10=fp0"},
> -			{0, "R3_w=inv2"},
> -			{1, "R3_w=inv4"},
> -			{2, "R3_w=inv8"},
> -			{3, "R3_w=inv16"},
> -			{4, "R3_w=inv32"},
> +			{0, "R3_w=2"},
> +			{1, "R3_w=4"},
> +			{2, "R3_w=8"},
> +			{3, "R3_w=16"},
> +			{4, "R3_w=32"},
> 		},
> 	},
> 	{
> @@ -67,19 +67,19 @@ static struct bpf_align_test tests[] = {
> 		},
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.matches = {
> -			{0, "R1=ctx(id=0,off=0,imm=0)"},
> +			{0, "R1=ctx(off=0,imm=0)"},
> 			{0, "R10=fp0"},
> -			{0, "R3_w=inv1"},
> -			{1, "R3_w=inv2"},
> -			{2, "R3_w=inv4"},
> -			{3, "R3_w=inv8"},
> -			{4, "R3_w=inv16"},
> -			{5, "R3_w=inv1"},
> -			{6, "R4_w=inv32"},
> -			{7, "R4_w=inv16"},
> -			{8, "R4_w=inv8"},
> -			{9, "R4_w=inv4"},
> -			{10, "R4_w=inv2"},
> +			{0, "R3_w=1"},
> +			{1, "R3_w=2"},
> +			{2, "R3_w=4"},
> +			{3, "R3_w=8"},
> +			{4, "R3_w=16"},
> +			{5, "R3_w=1"},
> +			{6, "R4_w=32"},
> +			{7, "R4_w=16"},
> +			{8, "R4_w=8"},
> +			{9, "R4_w=4"},
> +			{10, "R4_w=2"},
> 		},
> 	},
> 	{
> @@ -96,14 +96,14 @@ static struct bpf_align_test tests[] = {
> 		},
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.matches = {
> -			{0, "R1=ctx(id=0,off=0,imm=0)"},
> +			{0, "R1=ctx(off=0,imm=0)"},
> 			{0, "R10=fp0"},
> -			{0, "R3_w=inv4"},
> -			{1, "R3_w=inv8"},
> -			{2, "R3_w=inv10"},
> -			{3, "R4_w=inv8"},
> -			{4, "R4_w=inv12"},
> -			{5, "R4_w=inv14"},
> +			{0, "R3_w=4"},
> +			{1, "R3_w=8"},
> +			{2, "R3_w=10"},
> +			{3, "R4_w=8"},
> +			{4, "R4_w=12"},
> +			{5, "R4_w=14"},
> 		},
> 	},
> 	{
> @@ -118,12 +118,12 @@ static struct bpf_align_test tests[] = {
> 		},
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.matches = {
> -			{0, "R1=ctx(id=0,off=0,imm=0)"},
> +			{0, "R1=ctx(off=0,imm=0)"},
> 			{0, "R10=fp0"},
> -			{0, "R3_w=inv7"},
> -			{1, "R3_w=inv7"},
> -			{2, "R3_w=inv14"},
> -			{3, "R3_w=inv56"},
> +			{0, "R3_w=7"},
> +			{1, "R3_w=7"},
> +			{2, "R3_w=14"},
> +			{3, "R3_w=56"},
> 		},
> 	},
> 
> @@ -161,19 +161,19 @@ static struct bpf_align_test tests[] = {
> 		},
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.matches = {
> -			{6, "R0_w=pkt(id=0,off=8,r=8,imm=0)"},
> -			{6, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{7, "R3_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
> -			{8, "R3_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{9, "R3_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
> -			{10, "R3_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> -			{12, "R3_w=pkt_end(id=0,off=0,imm=0)"},
> -			{17, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{18, "R4_w=inv(id=0,umax_value=8160,var_off=(0x0; 0x1fe0))"},
> -			{19, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> -			{20, "R4_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
> -			{21, "R4_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{22, "R4_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
> +			{6, "R0_w=pkt(off=8,r=8,imm=0)"},
> +			{6, "R3_w=(umax=255,var_off=(0x0; 0xff))"},
> +			{7, "R3_w=(umax=510,var_off=(0x0; 0x1fe))"},
> +			{8, "R3_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> +			{9, "R3_w=(umax=2040,var_off=(0x0; 0x7f8))"},
> +			{10, "R3_w=(umax=4080,var_off=(0x0; 0xff0))"},
> +			{12, "R3_w=pkt_end(off=0,imm=0)"},
> +			{17, "R4_w=(umax=255,var_off=(0x0; 0xff))"},
> +			{18, "R4_w=(umax=8160,var_off=(0x0; 0x1fe0))"},
> +			{19, "R4_w=(umax=4080,var_off=(0x0; 0xff0))"},
> +			{20, "R4_w=(umax=2040,var_off=(0x0; 0x7f8))"},
> +			{21, "R4_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> +			{22, "R4_w=(umax=510,var_off=(0x0; 0x1fe))"},
> 		},
> 	},
> 	{
> @@ -194,16 +194,16 @@ static struct bpf_align_test tests[] = {
> 		},
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.matches = {
> -			{6, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{7, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{8, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{9, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{10, "R4_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
> -			{11, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{12, "R4_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{13, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{14, "R4_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
> -			{15, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> +			{6, "R3_w=(umax=255,var_off=(0x0; 0xff))"},
> +			{7, "R4_w=(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{8, "R4_w=(umax=255,var_off=(0x0; 0xff))"},
> +			{9, "R4_w=(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{10, "R4_w=(umax=510,var_off=(0x0; 0x1fe))"},
> +			{11, "R4_w=(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{12, "R4_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> +			{13, "R4_w=(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{14, "R4_w=(umax=2040,var_off=(0x0; 0x7f8))"},
> +			{15, "R4_w=(umax=4080,var_off=(0x0; 0xff0))"},
> 		},
> 	},
> 	{
> @@ -234,14 +234,14 @@ static struct bpf_align_test tests[] = {
> 		},
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.matches = {
> -			{2, "R5_w=pkt(id=0,off=0,r=0,imm=0)"},
> -			{4, "R5_w=pkt(id=0,off=14,r=0,imm=0)"},
> -			{5, "R4_w=pkt(id=0,off=14,r=0,imm=0)"},
> -			{9, "R2=pkt(id=0,off=0,r=18,imm=0)"},
> -			{10, "R5=pkt(id=0,off=14,r=18,imm=0)"},
> -			{10, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{13, "R4_w=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff))"},
> -			{14, "R4_w=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff))"},
> +			{2, "R5_w=pkt(off=0,r=0,imm=0)"},
> +			{4, "R5_w=pkt(off=14,r=0,imm=0)"},
> +			{5, "R4_w=pkt(off=14,r=0,imm=0)"},
> +			{9, "R2=pkt(off=0,r=18,imm=0)"},
> +			{10, "R5=pkt(off=14,r=18,imm=0)"},
> +			{10, "R4_w=(umax=255,var_off=(0x0; 0xff))"},
> +			{13, "R4_w=(umax=65535,var_off=(0x0; 0xffff))"},
> +			{14, "R4_w=(umax=65535,var_off=(0x0; 0xffff))"},
> 		},
> 	},
> 	{
> @@ -296,59 +296,59 @@ static struct bpf_align_test tests[] = {
> 			/* Calculated offset in R6 has unknown value, but known
> 			 * alignment of 4.
> 			 */
> -			{6, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
> -			{7, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{6, "R2_w=pkt(off=0,r=8,imm=0)"},
> +			{7, "R6_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Offset is added to packet pointer R5, resulting in
> 			 * known fixed offset, and variable offset from R6.
> 			 */
> -			{11, "R5_w=pkt(id=1,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{11, "R5_w=pkt(id=1,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* At the time the word size load is performed from R5,
> 			 * it's total offset is NET_IP_ALIGN + reg->off (0) +
> 			 * reg->aux_off (14) which is 16.  Then the variable
> 			 * offset is considered using reg->aux_off_align which
> 			 * is 4 and meets the load's requirements.
> 			 */
> -			{15, "R4=pkt(id=1,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{15, "R5=pkt(id=1,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{15, "R4=pkt(id=1,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
> +			{15, "R5=pkt(id=1,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Variable offset is added to R5 packet pointer,
> 			 * resulting in auxiliary alignment of 4.
> 			 */
> -			{17, "R5_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{17, "R5_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Constant offset is added to R5, resulting in
> 			 * reg->off of 14.
> 			 */
> -			{18, "R5_w=pkt(id=2,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{18, "R5_w=pkt(id=2,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* At the time the word size load is performed from R5,
> 			 * its total fixed offset is NET_IP_ALIGN + reg->off
> 			 * (14) which is 16.  Then the variable offset is 4-byte
> 			 * aligned, so the total offset is 4-byte aligned and
> 			 * meets the load's requirements.
> 			 */
> -			{23, "R4=pkt(id=2,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{23, "R5=pkt(id=2,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{23, "R4=pkt(id=2,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
> +			{23, "R5=pkt(id=2,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Constant offset is added to R5 packet pointer,
> 			 * resulting in reg->off value of 14.
> 			 */
> -			{25, "R5_w=pkt(id=0,off=14,r=8"},
> +			{25, "R5_w=pkt(off=14,r=8"},
> 			/* Variable offset is added to R5, resulting in a
> 			 * variable offset of (4n).
> 			 */
> -			{26, "R5_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{26, "R5_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Constant is added to R5 again, setting reg->off to 18. */
> -			{27, "R5_w=pkt(id=3,off=18,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{27, "R5_w=pkt(id=3,off=18,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* And once more we add a variable; resulting var_off
> 			 * is still (4n), fixed offset is not changed.
> 			 * Also, we create a new reg->id.
> 			 */
> -			{28, "R5_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
> +			{28, "R5_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
> 			/* At the time the word size load is performed from R5,
> 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
> 			 * which is 20.  Then the variable offset is (4n), so
> 			 * the total offset is 4-byte aligned and meets the
> 			 * load's requirements.
> 			 */
> -			{33, "R4=pkt(id=4,off=22,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
> -			{33, "R5=pkt(id=4,off=18,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
> +			{33, "R4=pkt(id=4,off=22,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
> +			{33, "R5=pkt(id=4,off=18,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
> 		},
> 	},
> 	{
> @@ -386,36 +386,36 @@ static struct bpf_align_test tests[] = {
> 			/* Calculated offset in R6 has unknown value, but known
> 			 * alignment of 4.
> 			 */
> -			{6, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
> -			{7, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{6, "R2_w=pkt(off=0,r=8,imm=0)"},
> +			{7, "R6_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Adding 14 makes R6 be (4n+2) */
> -			{8, "R6_w=inv(id=0,umin_value=14,umax_value=1034,var_off=(0x2; 0x7fc))"},
> +			{8, "R6_w=(umin=14,umax=1034,var_off=(0x2; 0x7fc))"},
> 			/* Packet pointer has (4n+2) offset */
> -			{11, "R5_w=pkt(id=1,off=0,r=0,umin_value=14,umax_value=1034,var_off=(0x2; 0x7fc)"},
> -			{12, "R4=pkt(id=1,off=4,r=0,umin_value=14,umax_value=1034,var_off=(0x2; 0x7fc)"},
> +			{11, "R5_w=pkt(id=1,off=0,r=0,umin=14,umax=1034,var_off=(0x2; 0x7fc)"},
> +			{12, "R4=pkt(id=1,off=4,r=0,umin=14,umax=1034,var_off=(0x2; 0x7fc)"},
> 			/* At the time the word size load is performed from R5,
> 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
> 			 * which is 2.  Then the variable offset is (4n+2), so
> 			 * the total offset is 4-byte aligned and meets the
> 			 * load's requirements.
> 			 */
> -			{15, "R5=pkt(id=1,off=0,r=4,umin_value=14,umax_value=1034,var_off=(0x2; 0x7fc)"},
> +			{15, "R5=pkt(id=1,off=0,r=4,umin=14,umax=1034,var_off=(0x2; 0x7fc)"},
> 			/* Newly read value in R6 was shifted left by 2, so has
> 			 * known alignment of 4.
> 			 */
> -			{17, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{17, "R6_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Added (4n) to packet pointer's (4n+2) var_off, giving
> 			 * another (4n+2).
> 			 */
> -			{19, "R5_w=pkt(id=2,off=0,r=0,umin_value=14,umax_value=2054,var_off=(0x2; 0xffc)"},
> -			{20, "R4=pkt(id=2,off=4,r=0,umin_value=14,umax_value=2054,var_off=(0x2; 0xffc)"},
> +			{19, "R5_w=pkt(id=2,off=0,r=0,umin=14,umax=2054,var_off=(0x2; 0xffc)"},
> +			{20, "R4=pkt(id=2,off=4,r=0,umin=14,umax=2054,var_off=(0x2; 0xffc)"},
> 			/* At the time the word size load is performed from R5,
> 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
> 			 * which is 2.  Then the variable offset is (4n+2), so
> 			 * the total offset is 4-byte aligned and meets the
> 			 * load's requirements.
> 			 */
> -			{23, "R5=pkt(id=2,off=0,r=4,umin_value=14,umax_value=2054,var_off=(0x2; 0xffc)"},
> +			{23, "R5=pkt(id=2,off=0,r=4,umin=14,umax=2054,var_off=(0x2; 0xffc)"},
> 		},
> 	},
> 	{
> @@ -448,18 +448,18 @@ static struct bpf_align_test tests[] = {
> 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> 		.result = REJECT,
> 		.matches = {
> -			{3, "R5_w=pkt_end(id=0,off=0,imm=0)"},
> +			{3, "R5_w=pkt_end(off=0,imm=0)"},
> 			/* (ptr - ptr) << 2 == unknown, (4n) */
> -			{5, "R5_w=inv(id=0,smax_value=9223372036854775804,umax_value=18446744073709551612,var_off=(0x0; 0xfffffffffffffffc)"},
> +			{5, "R5_w=(smax=9223372036854775804,umax=18446744073709551612,var_off=(0x0; 0xfffffffffffffffc)"},
> 			/* (4n) + 14 == (4n+2).  We blow our bounds, because
> 			 * the add could overflow.
> 			 */
> -			{6, "R5_w=inv(id=0,smin_value=-9223372036854775806,smax_value=9223372036854775806,umin_value=2,umax_value=18446744073709551614,var_off=(0x2; 0xfffffffffffffffc)"},
> +			{6, "R5_w=(smin=-9223372036854775806,smax=9223372036854775806,umin=2,umax=18446744073709551614,var_off=(0x2; 0xfffffffffffffffc)"},
> 			/* Checked s>=0 */
> -			{9, "R5=inv(id=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> +			{9, "R5=(umin=2,umax=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> 			/* packet pointer + nonnegative (4n+2) */
> -			{11, "R6_w=pkt(id=1,off=0,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> -			{12, "R4_w=pkt(id=1,off=4,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> +			{11, "R6_w=pkt(id=1,off=0,r=0,umin=2,umax=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> +			{12, "R4_w=pkt(id=1,off=4,r=0,umin=2,umax=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> 			/* NET_IP_ALIGN + (4n+2) == (4n), alignment is fine.
> 			 * We checked the bounds, but it might have been able
> 			 * to overflow if the packet pointer started in the
> @@ -467,7 +467,7 @@ static struct bpf_align_test tests[] = {
> 			 * So we did not get a 'range' on R6, and the access
> 			 * attempt will fail.
> 			 */
> -			{15, "R6_w=pkt(id=1,off=0,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> +			{15, "R6_w=pkt(id=1,off=0,r=0,umin=2,umax=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc)"},
> 		}
> 	},
> 	{
> @@ -502,23 +502,23 @@ static struct bpf_align_test tests[] = {
> 			/* Calculated offset in R6 has unknown value, but known
> 			 * alignment of 4.
> 			 */
> -			{6, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
> -			{8, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{6, "R2_w=pkt(off=0,r=8,imm=0)"},
> +			{8, "R6_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Adding 14 makes R6 be (4n+2) */
> -			{9, "R6_w=inv(id=0,umin_value=14,umax_value=1034,var_off=(0x2; 0x7fc))"},
> +			{9, "R6_w=(umin=14,umax=1034,var_off=(0x2; 0x7fc))"},
> 			/* New unknown value in R7 is (4n) */
> -			{10, "R7_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> +			{10, "R7_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> 			/* Subtracting it from R6 blows our unsigned bounds */
> -			{11, "R6=inv(id=0,smin_value=-1006,smax_value=1034,umin_value=2,umax_value=18446744073709551614,var_off=(0x2; 0xfffffffffffffffc)"},
> +			{11, "R6=(smin=-1006,smax=1034,umin=2,umax=18446744073709551614,var_off=(0x2; 0xfffffffffffffffc)"},
> 			/* Checked s>= 0 */
> -			{14, "R6=inv(id=0,umin_value=2,umax_value=1034,var_off=(0x2; 0x7fc))"},
> +			{14, "R6=(umin=2,umax=1034,var_off=(0x2; 0x7fc))"},
> 			/* At the time the word size load is performed from R5,
> 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
> 			 * which is 2.  Then the variable offset is (4n+2), so
> 			 * the total offset is 4-byte aligned and meets the
> 			 * load's requirements.
> 			 */
> -			{20, "R5=pkt(id=2,off=0,r=4,umin_value=2,umax_value=1034,var_off=(0x2; 0x7fc)"},
> +			{20, "R5=pkt(id=2,off=0,r=4,umin=2,umax=1034,var_off=(0x2; 0x7fc)"},
> 
> 		},
> 	},
> @@ -556,23 +556,23 @@ static struct bpf_align_test tests[] = {
> 			/* Calculated offset in R6 has unknown value, but known
> 			 * alignment of 4.
> 			 */
> -			{6, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
> -			{9, "R6_w=inv(id=0,umax_value=60,var_off=(0x0; 0x3c))"},
> +			{6, "R2_w=pkt(off=0,r=8,imm=0)"},
> +			{9, "R6_w=(umax=60,var_off=(0x0; 0x3c))"},
> 			/* Adding 14 makes R6 be (4n+2) */
> -			{10, "R6_w=inv(id=0,umin_value=14,umax_value=74,var_off=(0x2; 0x7c))"},
> +			{10, "R6_w=(umin=14,umax=74,var_off=(0x2; 0x7c))"},
> 			/* Subtracting from packet pointer overflows ubounds */
> -			{13, "R5_w=pkt(id=2,off=0,r=8,umin_value=18446744073709551542,umax_value=18446744073709551602,var_off=(0xffffffffffffff82; 0x7c)"},
> +			{13, "R5_w=pkt(id=2,off=0,r=8,umin=18446744073709551542,umax=18446744073709551602,var_off=(0xffffffffffffff82; 0x7c)"},
> 			/* New unknown value in R7 is (4n), >= 76 */
> -			{14, "R7_w=inv(id=0,umin_value=76,umax_value=1096,var_off=(0x0; 0x7fc))"},
> +			{14, "R7_w=(umin=76,umax=1096,var_off=(0x0; 0x7fc))"},
> 			/* Adding it to packet pointer gives nice bounds again */
> -			{16, "R5_w=pkt(id=3,off=0,r=0,umin_value=2,umax_value=1082,var_off=(0x2; 0xfffffffc)"},
> +			{16, "R5_w=pkt(id=3,off=0,r=0,umin=2,umax=1082,var_off=(0x2; 0xfffffffc)"},
> 			/* At the time the word size load is performed from R5,
> 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
> 			 * which is 2.  Then the variable offset is (4n+2), so
> 			 * the total offset is 4-byte aligned and meets the
> 			 * load's requirements.
> 			 */
> -			{20, "R5=pkt(id=3,off=0,r=4,umin_value=2,umax_value=1082,var_off=(0x2; 0xfffffffc)"},
> +			{20, "R5=pkt(id=3,off=0,r=4,umin=2,umax=1082,var_off=(0x2; 0xfffffffc)"},
> 		},
> 	},
> };
> @@ -648,8 +648,8 @@ static int do_test_single(struct bpf_align_test *test)
> 			/* Check the next line as well in case the previous line
> 			 * did not have a corresponding bpf insn. Example:
> 			 * func#0 @0
> -			 * 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
> -			 * 0: (b7) r3 = 2                 ; R3_w=inv2
> +			 * 0: R1=ctx(off=0,imm=0) R10=fp0
> +			 * 0: (b7) r3 = 2                 ; R3_w=2
> 			 */
> 			if (!strstr(line_ptr, m.match)) {
> 				cur_line = -1;
> diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> index 1ef377a7e731..fe9a23e65ef4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> @@ -78,7 +78,7 @@ static void obj_load_log_buf(void)
> 	ASSERT_OK_PTR(strstr(libbpf_log_buf, "prog 'bad_prog': BPF program load failed"),
> 		      "libbpf_log_not_empty");
> 	ASSERT_OK_PTR(strstr(obj_log_buf, "DATASEC license"), "obj_log_not_empty");
> -	ASSERT_OK_PTR(strstr(good_log_buf, "0: R1=ctx(id=0,off=0,imm=0) R10=fp0"),
> +	ASSERT_OK_PTR(strstr(good_log_buf, "0: R1=ctx(off=0,imm=0) R10=fp0"),
> 		      "good_log_verbose");
> 	ASSERT_OK_PTR(strstr(bad_log_buf, "invalid access to map value, value_size=16 off=16000 size=4"),
> 		      "bad_log_not_empty");
> @@ -175,7 +175,7 @@ static void bpf_prog_load_log_buf(void)
> 	opts.log_level = 2;
> 	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "good_prog", "GPL",
> 			   good_prog_insns, good_prog_insn_cnt, &opts);
> -	ASSERT_OK_PTR(strstr(log_buf, "0: R1=ctx(id=0,off=0,imm=0) R10=fp0"), "good_log_2");
> +	ASSERT_OK_PTR(strstr(log_buf, "0: R1=ctx(off=0,imm=0) R10=fp0"), "good_log_2");
> 	ASSERT_GE(fd, 0, "good_fd2");
> 	if (fd >= 0)
> 		close(fd);
> -- 
> 2.30.2
> 

