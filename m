Return-Path: <bpf+bounces-11007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142367B0F8A
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 01:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B224A28217B
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B54D8E0;
	Wed, 27 Sep 2023 23:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A81C6B3
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 23:21:14 +0000 (UTC)
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A2F9
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 16:21:12 -0700 (PDT)
Received: from pps.filterd (m0166259.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RMaTKe025368;
	Wed, 27 Sep 2023 23:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 from : to : subject : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=kKATYQYwrqXy2GUG5yv8QhSqwSfsC+inxXmDNh24HQs=;
 b=XiV4iavBuaUFdkwRJYnGE8Z7YldlBqOaO5Oov5niF0GXSDTQ2f/4ulmP5bK9gBAJvKEN
 +sMImOu/gVck0ViK53UtpqmMaCq++RceEW9XSlR16mh/PUhm4z0GUNrzQZD7a86d0HPv
 voEaQEI2jIqbW892Sf46tRZtTknnqnR5NHMLQfeczcZFdRjiCHmVXJA5aAN3DLZS3nE5
 8T63fbfB1jC9SJGxUc19mPKj9ftGoXZMHXcpem5KQS2Je9oPgqNLbUWJoxCG1Q7+0/4K
 zV6YOFrPKMwXlQnQRdoUqvxF8OT2znI5d76GXVeKfgZ/mcZtMDy/GGaXc94LkP5dnmcs 1A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3tc79dh3ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Sep 2023 23:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVM+GNblZU85akW7nx+jthAvdmu9v8mzlW1JQ6+PcLwEG7a5lY5tvIj9fA11B8B9KGKPN5NXxWB9pefm39vYnrLEyPbfZ8td4+lwHNHbwj8KmWgpl8MMLov+PhB7Y3caJ7QvSRHcJ4W+zsjkAY8EGHCwV3wZ12NUcETT18i1usf/c2xcXuVo3pY/V6OSz1rfLCklhvUUOEfUb8BxG6FkH4Db9YKHjAVt1P5duTymP/xNQQk3yvdxkmGfH+R+AVwS8WHbSZQ9vqQfIsV16Hs1ft9+tGTRH9ss7q8hyEBiPkzgT68erUX2U69nXp2zVlpYPhVWq+BRv94WdNUWOeD3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKATYQYwrqXy2GUG5yv8QhSqwSfsC+inxXmDNh24HQs=;
 b=A0RH1efUUpQtP6GkaNZchMRWIn3BPNQMuQXFk+FNjU/6nfbChFpF3qmtIPBefgEoe2NxS6od8qQQGTwR3/K/LWpkW4fI0GIhiOF2GTAQoaQ7fOCmlFrPEDVpl9PhXhCHAw6brIrsR2cZVZPH+1tibybmUGrw2aCg0EEvg9M/DKr0uuZduWxU8dmLCtrqgzjpPAbA4jsR13V9D+I1E6IevLutsouGUXB9D00ynFo/8Z3ru8npZIsSOKg4VY2+lfG4TxDA7LyWzFmSXUHyReqZtqhMU+lXULWrx0AD1/UoIf8rraSQ6cLqrhB89m5RYnVasoEpRHzDJSP5inUQt1VKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 23:20:46 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::457f:dc8a:bfb1:5974]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::457f:dc8a:bfb1:5974%7]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 23:19:13 +0000
Message-ID: <ed2a63a4-434c-4cf7-ad27-c17f75bbdf84@illinois.edu>
Date: Wed, 27 Sep 2023 18:19:10 -0500
User-Agent: Mozilla Thunderbird
From: ruowenq2@illinois.edu
To: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jinghao7@illinois.edu,
        keescook@chromium.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jinghao Jia <jinghao@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 1/1] samples/bpf: Add -fsanitize=bounds to
 userspace programs
References: <20230927045030.224548-1-ruowenq2@illinois.edu>
 <20230927045030.224548-2-ruowenq2@illinois.edu> <ZRQMASduySxE+TO2@krava>
In-Reply-To: <ZRQMASduySxE+TO2@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::25) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6613fb-4aad-48ee-cce4-08dbbfb028a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EXcz9/pZWuXBTDUl68rHEvNCFOw6W3TI0bvsBZjAJ+GVUAthi6bkU3np8B1rAOkF7l4kiGb8agjwzWxPXHQsOAlSu8LM7+dzRAOpYfaUx6RqSYdd1x3kfN8IqfhqYGm1OO1fLpB7u7gfFskrPnmqqo22BArz2M0yB602Zd4AaiSOtwCsnx73oXBgeiZojFFUXIxhOUmtidwCTg0oB/a+Uw7LeL58etJ7lJaASKboQtH7u9xKE8tOhHO2l0EPIc2e5pF3e9pmrhCHv73rmOmyBtOg6HOphCz4Txr4TkKTcVjR9DWZLMbA8+uKydI8YAh1E4cx3nnaFIAX9dnM0iSvQBTaxLkzJ33j7ezG78nFT/UlKyKdie8e5UJm+PbIWYgXehx5MSYna/e7TdmijZSKm9CDt9XD/Ee1A5BmRERPzHICiebDsOuN/4wPAg5PbTo1J2hmAHPGWxVfp/WGjDd1X+TerPmJiBJ8lsRPoswtHVm5uw40Aay9djUox14Hf0WD5NTFYWqQnuL5itDMuuYHSY5DZ6CtlTPDI61SpW47GLE3chEbrZ4Ak5Uaa8arZBlXYXLy+QMKXlQGWMF8Ope52ro9ufrQfCvs+uZNEliiLlYucZctU+Zfwe7dUn7pUIIvS1amUOLVsYw5oY/3gm9xjg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(786003)(5660300002)(8936002)(66946007)(8676002)(41300700001)(110136005)(66556008)(66476007)(31686004)(2906002)(75432002)(53546011)(9686003)(2616005)(6506007)(31696002)(26005)(36756003)(6486002)(478600001)(86362001)(38100700002)(83380400001)(6512007)(2292003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFVQQi9PelppL2ladHc4MHZRenB5d1RiU3ZqV3ltelQ3WWl1d081UGJNVnJH?=
 =?utf-8?B?UUhWTVB6TGRwaGlqUlJPeTFiNFgxclJTQlNtejhaV2tTMGxScG1ZMmY3UW5p?=
 =?utf-8?B?dytxU3Z0MmJHTTFDQklBV3F2NDNyN0pMTGo5VS9QSm5UUXlRNG9hTGhEZjhq?=
 =?utf-8?B?MmRJcFVNQ3IzYzdiakNRK0VmWXhmOVFxZUU4dTJrdHRiV3VoWitWMkUyQjk3?=
 =?utf-8?B?NXU2UUZzR2dEemFuaHl0REVVWE0zWHFnSWJ1VHIvZ2VPUW5PZlkrVWtHdkNK?=
 =?utf-8?B?WitONTZMLy96dVpvdVZLYXE2NUY2c2pFbml1QXcrYWl0dzZReU5wd0psZGRp?=
 =?utf-8?B?U092aE9yclpSeG1JSVpKY2lmWGpNUFlMK0JEcHROR3BJaHlvdXdYSUI1bnJu?=
 =?utf-8?B?T3EwYzNzL2l2V2dSUGNxcjVNcXV1UUR1M0N4dXRlT2FncVpXVFd2Y2VIYlJY?=
 =?utf-8?B?VTdCb1hOTUNzK014Mk92eEZEYWpDREdReHRPTzdQbXErbllud054L0RRWmVm?=
 =?utf-8?B?clAyeFRLZ2w3VTRqWERCZHBFRkkyTmNySE5JNEEwNTdXeTJwL2tWS3p1VXNy?=
 =?utf-8?B?ZFk1dkFuVmFWN2lWZkI0eGVRNlR4VWduL0Q2aVJ5VFRDUUJrWTU0MzFzbk9n?=
 =?utf-8?B?aC9wZzNieXNmbWRsTFB4ZDZvaEVTcnpEMDk2RFlVSmVCcC9HRlRERmJESmN6?=
 =?utf-8?B?UGx4ekY5QUlINVhnanUzTmpsR2FEdjhXdlpoUTlOWFRrSWNNZWhuME5KQWhU?=
 =?utf-8?B?NzQyOFRsblB3VUFQSm4xYlJ3eUd6TWUyWVpKNWd6UkdWbU40cXN4V0xUUENB?=
 =?utf-8?B?eEJ0Ny9vQVhHVTVUSkFEdmhmVVpURWthUEc0aEV1SDkzc0xVTU5BQVl3SGxL?=
 =?utf-8?B?YlEwMWhrMkJlL0htSk4zSW1MT1RmVUhxWERsNzBKdERkMHNwZ0daYUpDSDJ1?=
 =?utf-8?B?YkdiL1lSdWREbEViU2J3SG5leWpMUU1leFE1ZVE0ZXZ6Z2RlSU5RZThhRkF6?=
 =?utf-8?B?VEdrS2FWYUN6UEJsRmxVYXltVytQK2QreERkT2VWNUpnQVhTTGwybE1Ld1Zs?=
 =?utf-8?B?eUVRN1pTRUlNV0JLK2xBcmNTSXlhV2JHNjlUUlkreEd3ZzRMVFFsOUVyRWUy?=
 =?utf-8?B?MzVGb29pZVY1ME9XeHNMVGFHTkZYNXFwVURFcWRHU2VQTTkvVTk5djhCTmR2?=
 =?utf-8?B?VVpieWd4MSs1akxMYUxSRnl1alk1NGgrdEREYW5RR00wYjVTSTZ6U0w4dTNx?=
 =?utf-8?B?dVlUbXovdGRIS01PYW16OHdQRS9ZUUQ0MHZEaURoNDJIc21zSkRXbnNlY3Az?=
 =?utf-8?B?U1NEVTBxNzV6S0RZMTRnY2ZVR2lGWVJqNEdlL2dxRlRvbVh1TXRjbm1SSE5I?=
 =?utf-8?B?RTl3bEhkUGxra0hNMXZVS1ZOUlZrRUlUVFREbTlFTms2Mkt0My93dWdVcitY?=
 =?utf-8?B?TDNYNWpYY1NvalN1QldmSHBQZi9zKzRTRE1ZUjA5bkpKSjhQNTFobHRiUDF3?=
 =?utf-8?B?WmQrckNPU09ZSFF5MC9KWnBLbFl6Yll1WElJN3pPcDVWRk5sVUdjMzBlUUdR?=
 =?utf-8?B?RGYwMmdvRjhkQzZQY1kwZ0Y4V0t5bUF4Yk8vSFFVc0QyUFhxS1BrTStua1B4?=
 =?utf-8?B?cnYxNXVhK3lQcmhOa2ZQemNLcis5WVFvTUhsNlBpWm9ZZFZoSFpXVmpTaFc0?=
 =?utf-8?B?akpzSnBFYzFtd2plcHRpNk5OSGUyZkg5WHNPNHVMZ3h1V2RKaXBhWmFYemlX?=
 =?utf-8?B?SUVnQWJKT1ZYR0tjZ3lqaXlUVHNza1l3M2pzanMvdnNRZmRncHdUMG5VWERy?=
 =?utf-8?B?VjZrRDFteHZaMFlTTU5NZElPSXQvNmthd3NHUlYvT1hMY054SFZwY3RmTzd3?=
 =?utf-8?B?NXR5OUxGKzN1Vk04dktKSVlTZVA0clF5emJRL3h6U2k2N3A3emVZUERRakJu?=
 =?utf-8?B?SlhJVmtmOHd5SUZvaDhreHplb2l3aGF6cDB0MTdxVWNuMGdzMlRxcFBJeWM2?=
 =?utf-8?B?eEVkV2o0TlEyWmRlaW14VmZZaUJkSHdLUHdOelFaMGlqOUoxNmNZOU4rdU5n?=
 =?utf-8?B?WU9pSHUxQU5nOVl6eEpDQjRZMFVpOHU0U3pxbzVOUEhSV1VEMWROT01vY1By?=
 =?utf-8?B?dWlCMVF5YUlESHhJK1FQeUVYdk9reGVFSUhyOU1lUFMzNWFMS0I0b0E2N1Ar?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6613fb-4aad-48ee-cce4-08dbbfb028a3
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 23:19:13.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY09QL2eTBiy9mhbhPr/WEAvku5wt0Z1ZYt+6pyiDbkddJl4nufOwRSCldWdMn93HXe3q3iRhZ8cI8MrwdMMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-Proofpoint-GUID: UQ0Fk-_YScn7c4Ue90GR3WadK_f7A9G8
X-Proofpoint-ORIG-GUID: UQ0Fk-_YScn7c4Ue90GR3WadK_f7A9G8
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309270201
X-Spam-Score: 0
X-Spam-OrigSender: ruowenq2@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/23 6:03 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> On Tue, Sep 26, 2023 at 11:50:30PM -0500, ruowenq2@illinois.edu wrote:
> > From: Ruowen Qin <ruowenq2@illinois.edu>
> >
> > The sanitizer flag, which is supported by both clang and gcc, would make
> > it easier to debug array index out-of-bounds problems in these programs.
> >
> > Make the Makfile smarter to detect ubsan support from the compiler and
> > add the '-fsanitize=bounds' accordingly.
> >
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
> > Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> > Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
> > ---
> >   samples/bpf/Makefile | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 6c707ebcebb9..90af76fa9dd8 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -169,6 +169,9 @@ endif
> >   TPROGS_CFLAGS += -Wall -O2
> >   TPROGS_CFLAGS += -Wmissing-prototypes
> >   TPROGS_CFLAGS += -Wstrict-prototypes
> > +TPROGS_CFLAGS += $(call try-run,\
> > +	printf "int main() { return 0; }" |\
> > +	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
> 
> I haven't checked deeply, but could we use just cc-option? looks simpler
> 
> TPROGS_CFLAGS += $(call cc-option, -fsanitize=bounds)
> 
> jirka

Hi, thanks for your quick reply! When checking for flags, cc-option does not execute the linker, but on Fedora, an error appears and stating that "/usr/lib64/libubsan.so.1.0.0" cannot be found during linking. So I try this seemingly cumbersome way.

Ruowen

> >   
> >   TPROGS_CFLAGS += -I$(objtree)/usr/include
> >   TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
> > -- 
> > 2.42.0
> >
> >
> 

