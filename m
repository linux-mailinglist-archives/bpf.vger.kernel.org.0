Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A446106B9
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 02:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiJ1AO5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 20:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiJ1AO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 20:14:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DA4C2D4
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 17:14:55 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMnADA030795
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 17:14:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=A5pqyXnjEJf3e1jn/XP6U4Xjvd3XDNKT9a/VvEQYmlk=;
 b=LeJDYWYkK6hrLKJb5oNFKG+A6UYk5FbmdMhuKAh+ydNrVYSa8wppFQEhMu8opSWuAvkq
 n3O8Ahx6OeJ4mVBaopdEKhNZFr0UdFysPNF7vUPp4XDLK/1v50jaq6hfK6CIxuersvsU
 t7TRPKjd+lLVN3cOuydY/4MAjYPa/PmBj+O2gB8uvNlxwhErxh/+GAWhY6dEkUSUxxjJ
 7vwImrRtCb/OWrcCwALxbeqwR+YX4+B2Bw6W/2HeJlAbOVKsatZhAFRqKl3lLncwFToN
 A+KC8NjC9hWQEaMe73L5icz9s9JyfVEPHfjcxp2JL0BttpJ2oAVNAhxHlQlsZ3WvC2gM KA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kfahk72e7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 17:14:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB5Zl187ZzaEgriYANUqbbUtnNM8f0n/sfpdVk+oJUie7DIa5IhSsY65ed2OWNVi9C63/vKN8tUUF6ZUnlJ//nMbzZl3AMJC0eYt81tyqfhlenSBg3np+upOYWgYJZyH8UgXsmE8WavF0TOTMPkvqvzCe7Kwr26vDBrxUeaZshiDqOmTSv8PVcrJVniMlXtfM5iiURbPxV8cB+GvWRNKAjO9kUE7VbyDE1FzS1FVIvScSkQ97UPbimNVjm1ynIF82Y6OW/FgbSrmPqLm5W7XFtDSfPjXtkzOEllczhljSadmsJAVCtGqos1RcmVgvSDhdXsRlAWYQ4SMpf/HVIJFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5pqyXnjEJf3e1jn/XP6U4Xjvd3XDNKT9a/VvEQYmlk=;
 b=gq0cKyl0eG+Y4BgjjScgp5nKyZVJ7YZofdzhXJVK7c8rgTpp8jhuV+u4Ph/x0uCItyhWnv3nzk2WtlC864PFGIq6IJbhgfVb4+RSdIxtZjY1GyA+JHVWwG6VJzMuihihhV1JzkRMoVDk3fXYihixHL5MDuXnrygrJKx7yS/tW50r0+p+30VH2ZLr2pwc3DDniRdOevDRvS+mivmycqSonS+SYl5V1Z/s4CrRUsZvoSl/lEjzfH7OtE8fzC3Kk2ZCdGcPm1Cla8HWRLfydu4JDODQv5iQh2USxi39sZATniyY3dm+GuIQAwmaowCoXWTjnlfUSkMWoh1vZsAM28dgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (2603:10b6:208:3d::12)
 by DM5PR15MB1737.namprd15.prod.outlook.com (2603:10b6:4:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 00:14:49 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::9c9f:91d9:37a3:5ea6]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::9c9f:91d9:37a3:5ea6%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 00:14:49 +0000
From:   Mykola Lysenko <mykolal@meta.com>
To:     Yonghong Song <yhs@meta.com>
CC:     Mykola Lysenko <mykolal@meta.com>, bpf <bpf@vger.kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@meta.com>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>
Subject: Re: [RFC bpf-next 09/12] kbuild: Header guards for types from
 include/uapi/*.h in kernel BTF
Thread-Topic: [RFC bpf-next 09/12] kbuild: Header guards for types from
 include/uapi/*.h in kernel BTF
Thread-Index: AQHY6MEq2nUfHOmLQEqxWnoqotLeaa4iloKAgAADOYCAAD/9AIAAFXaAgAAD5AA=
Date:   Fri, 28 Oct 2022 00:14:48 +0000
Message-ID: <97B01B2E-0F57-4FB0-BF8E-CB63DEAB9F57@fb.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <20221025222802.2295103-10-eddyz87@gmail.com>
 <dacaeb37-c55a-a328-61f2-77324efbc822@meta.com>
 <6e57811b-229a-e4f8-ca7e-fe826cde4be4@meta.com>
 <7a3ebc5f-b07f-0336-abb1-627f7a73b2cb@meta.com>
 <237df1d8b2c0bf546ab81abb73ae0b78e2c0cbaa.camel@gmail.com>
In-Reply-To: <237df1d8b2c0bf546ab81abb73ae0b78e2c0cbaa.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3213:EE_|DM5PR15MB1737:EE_
x-ms-office365-filtering-correlation-id: 277c9ce6-d839-403e-aae5-08dab8796d3e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eqiTt7yAbvmpiG0K2UmP82M3FGu+g0XaMgNkHzFlFITdKKLuk2c0DjwobemPbTu9UQl0Vz4KziaKArH/djaSBEp7Fh6kabgeaVXyjRfqBiQgjijqzDEGt1aLYH1gHzLE3mXKYH/eB74UZ77rr22wvjTrYINf3GKg1OJhoV7cEZr+9Ymp27ojKsHZhSW5UqAgDE7kVCS1Gk2uVOVvGAYYfBVdtL8tVVbjtL65TuvY4+9JjYa+wg1IJVE2XYRzokTvmixRBaxCuNBn9PS1TeAHPiR/BJEYwRqM4P43Cabyct+PKLMmzpRn7m6Cbya7qWknU/yf+gJXKpDKYhh0aEwqjZ/tnfAVIsdobz3xdWIT3zCfbivzpYh0LQDr+7Y3Kp/RdzYtxKGLGGufyD7Z9/S39hF99QFzoBWVkjr1wK57DcmeWythZmcCvi8H+s1Xt2uy4ML1dwlsoS7R9hjAB8jJ0n/1F9sTQ5GGYUCRdlaiWpnkMhYj4GBUt+syYg5dbMOFjpp4cDtJ0MkiCKMYZMTMWmjoAYeaC7TWEKvOSUIQuuTn9K0+THLyAG+3IvxW1cCi9IpwDPlTH5UzJ0W7UVpUN6YY47A4KK/9VfKuxXv3O1Wf4KdWyBIDVCfj72ZOcbZQhxhZWPh1F85GJpkxJWyP8otUjI73n14YfDS3OCbM/x2R69TfMmvCFgPHtIQF3CAy/z5QY1sKY8sIalNgYvuuUKpkbCG9ka1W2q9cMvUe26NLWZAuOTb7T7a3VmmMhj/ndn5YHO0yzDOELG/+cG4neA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3213.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(36756003)(6512007)(33656002)(86362001)(4001150100001)(5660300002)(122000001)(186003)(83380400001)(2906002)(38070700005)(4326008)(53546011)(6506007)(76116006)(38100700002)(71200400001)(91956017)(6486002)(54906003)(316002)(66446008)(66476007)(66556008)(8676002)(64756008)(478600001)(9686003)(66946007)(6636002)(41300700001)(6862004)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sZrzNmRh58dW7k6ZLCwZ5xhbCUByFunqS0FnG+twxaipA4JtNrfLmZ6gzm9d?=
 =?us-ascii?Q?pFKv4gU1/2bp42PsrKTo89+fLX86pUNxqdVAjsxlq1btqO9M/RR4gGUmcPP6?=
 =?us-ascii?Q?YlywdKFbjm225rg+IdXylHwLVbY19LTm6Pyog/cvslVL0jmRBGkMMH8aT8Ie?=
 =?us-ascii?Q?MMRFmt6HkuPEyBqJ2wD6ZMeNIk+VfrEU5dsCIUe8Kc9YSRciPY6w+rrumDSt?=
 =?us-ascii?Q?7lCmXyJrOvqfa6ULJ50sGK9zdL9sAoucTPGMz8qVYoCMBfotz2fBb7HxuIPi?=
 =?us-ascii?Q?hjF6KqR9V7XzgkujPi1DqlzkObUgy5++L0cyr67r7TjJFYmeXK+KtmDDDdm3?=
 =?us-ascii?Q?Z7cQo2RzMMqZcjCxwIdTCNOlCFVumXEcpZBCDyeEQyhLj7de54J1h7hzsQh1?=
 =?us-ascii?Q?AJmkucyypRbaXz+F7JsX7DAF02sJ5WSjaiyZ857DpnKCba1jQ7RrnQZoa/U+?=
 =?us-ascii?Q?6nyGnYjBLr2fyopFV5sbWRvZLeSZp+F47mfsvVqLov2vZtTxwbZudqOXzLf/?=
 =?us-ascii?Q?LK0Fj/YknrMXmhCDVraMZPHb29NRjoZ5EP0jGNWOr2T++4ibB/jNAhDPKVTW?=
 =?us-ascii?Q?oW1TurNLZzh7suA4fPw+f3kij7eLqaILxIAOFRk5P25n5g8uN0Rfbq1N5edl?=
 =?us-ascii?Q?sgQd4y4TpP2f9Pkq9cXaKs9J82/dch5JHT67Uc0/zqIzinU79S8+vi4CzpwS?=
 =?us-ascii?Q?dszQ6a1ZoGqyeDM3Urru0l3TdNaEEob/WzZ4smOU6gBh9uL2/85zoLF1mfl/?=
 =?us-ascii?Q?uUKtA6r+l1srHg7fOHbDJtC88B93LE+lTl7AhDJszkQO+WgKgU0v1IA7LyO+?=
 =?us-ascii?Q?7hnJt4f6MpN6vm4iLl8AtpFOy4lkRwwoCDWJumkjy4Dh7M3zZcZhttundLZP?=
 =?us-ascii?Q?2jQi33BttIXxWpj1mMEYBkC5mT62BiwTZjC6Lr37mR06mDknJkk97c36ujSE?=
 =?us-ascii?Q?kf5M+0NKvQP00yD3iGIksCEjn2WpkQblwrq8iGMpiEit8q2ZPFZF4KApuaYy?=
 =?us-ascii?Q?aLiroCmGw3fWzyBCHuZGntpNe5vifeDstGTcJCs/a5KrM45yh35FrsU9vHJn?=
 =?us-ascii?Q?H41sY9b8HZ067odCp36iEvqyTA7qPI85yUPLq22+r8PA52OOUEbhtmPW+7TK?=
 =?us-ascii?Q?E/BM+WKiGC1kZIsUitH0oW3kdVRNVKqL94mqoxtgXiXZPaNF1P7piEMbFS1m?=
 =?us-ascii?Q?PctWDicW8W9m7Qa5joaYM2ZVFewEcZDHVV4mF7LQd68gIpiOZeWxoi7O4pCM?=
 =?us-ascii?Q?9rMlbD2yWuN7SIzR2oolkDN59c1KApMBFskcobCVrV9nUV1CgucGMOBDTIxx?=
 =?us-ascii?Q?Hx+fbxMmSZ4cEgXcXF+Rr3cQQfl9i25qA/unuU7B+XVAmXw8LFX47SxcS23l?=
 =?us-ascii?Q?6gFDcb10KNilb45YVpkJDCUweM7kfG1aoP0KspZOhd6lf1Bph2BJYPQLBFy8?=
 =?us-ascii?Q?Vza2Mii3wwt52OeVCKeIZnlhbUNSfysz9YMWAKKGfxTYacDF5FXyImd4+cpQ?=
 =?us-ascii?Q?htivPaV9Ux57nGlT+25JWHQdrDHmE6uRE4wjih2BRoRUpmWpoWwyB6g+5LAs?=
 =?us-ascii?Q?bOwInELcpROO876xlKPmUA+RBGGkSeef5mDKu5eueYUpWTRiK6w9CxnwtADl?=
 =?us-ascii?Q?3/V1YZbxLRlgg0OHni8OCw2BzLIG9r8/SWMeLSdid8mZSntJV211nH02olKr?=
 =?us-ascii?Q?gya+gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F92EA2C089A1C4291F966AD1A6048F2@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3213.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277c9ce6-d839-403e-aae5-08dab8796d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 00:14:48.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWe7AghJ0s4OFogEjtABVboFFHvBODP8UQ6hSxxcpmlBBJVn6+Q19igJ9OOBqUXimNvmD6m7P6tnTpXP4Pr/Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1737
X-Proofpoint-ORIG-GUID: sEVJakGFyeOYFLufIGgZUEd126eJmbur
X-Proofpoint-GUID: sEVJakGFyeOYFLufIGgZUEd126eJmbur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong,

build will be failing without merged pahole changes.

> On Oct 27, 2022, at 5:00 PM, Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> On Thu, 2022-10-27 at 15:44 -0700, Yonghong Song wrote:
>> 
>> On 10/27/22 11:55 AM, Yonghong Song wrote:
>>> 
>>> 
>>> On 10/27/22 11:43 AM, Yonghong Song wrote:
>>>> 
>>>> 
>>>> On 10/25/22 3:27 PM, Eduard Zingerman wrote:
>>>>> Use pahole --header_guards_db flag to enable encoding of header guard
>>>>> information in kernel BTF. The actual correspondence between header
>>>>> file and guard string is computed by the scripts/infer_header_guards.pl.
>>>>> 
>>>>> The encoded header guard information could be used to restore the
>>>>> original guards in the vmlinux.h, e.g.:
>>>>> 
>>>>>      include/uapi/linux/tcp.h:
>>>>> 
>>>>>        #ifndef _UAPI_LINUX_TCP_H
>>>>>        #define _UAPI_LINUX_TCP_H
>>>>>        ...
>>>>>        union tcp_word_hdr {
>>>>>          struct tcphdr hdr;
>>>>>          __be32        words[5];
>>>>>        };
>>>>>        ...
>>>>>        #endif /* _UAPI_LINUX_TCP_H */
>>>>> 
>>>>>      vmlinux.h:
>>>>> 
>>>>>        ...
>>>>>        #ifndef _UAPI_LINUX_TCP_H
>>>>> 
>>>>>        union tcp_word_hdr {
>>>>>          struct tcphdr hdr;
>>>>>          __be32 words[5];
>>>>>        };
>>>>> 
>>>>>        #endif /* _UAPI_LINUX_TCP_H */
>>>>>        ...
>>>>> 
>>>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>>>> ---
>>>>>   scripts/link-vmlinux.sh | 13 ++++++++++++-
>>>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>>>>> index 918470d768e9..f57f621eda1f 100755
>>>>> --- a/scripts/link-vmlinux.sh
>>>>> +++ b/scripts/link-vmlinux.sh
>>>>> @@ -110,6 +110,7 @@ vmlinux_link()
>>>>>   gen_btf()
>>>>>   {
>>>>>       local pahole_ver
>>>>> +    local extra_flags
>>>>>       if ! [ -x "$(command -v ${PAHOLE})" ]; then
>>>>>           echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
>>>>> @@ -122,10 +123,20 @@ gen_btf()
>>>>>           return 1
>>>>>       fi
>>>>> +    if [ "${pahole_ver}" -ge "124" ]; then
>>>>> +        scripts/infer_header_guards.pl \
>>>> 
>>>> We should have full path like
>>>>      ${srctree}/scripts/infer_header_guards.pl
>>>> so it can work if build directory is different from source directory.
>>> 
>>> handling arguments for infer_header_guards.pl should also take
>>> care of full file path.
>>> 
>>> + /home/yhs/work/bpf-next/scripts/infer_header_guards.pl include/uapi 
>>> include/generated/uapi arch/x86/include/uapi 
>>> arch/x86/include/generated/uapi
>>> + return 1
>> 
>> Also, please pay attention to bpf selftest result. I see quite a
>> few selftest failures with this patch set.
> 
> Hi Yonghong,
> 
> Could you please copy-paste some of the error reports? I just re-run
> the selftests locally and have test_maps, test_verifier, test_progs
> and test_progs-no_alu32 passing.
> 
> Thanks,
> Eduard
> 
>> 
>>>> 
>>>>> +            include/uapi \
>>>>> +            include/generated/uapi \
>>>>> +            arch/${SRCARCH}/include/uapi \
>>>>> +            arch/${SRCARCH}/include/generated/uapi \
>>>>> +            > .btf.uapi_header_guards || return 1;
>>>>> +        extra_flags="--header_guards_db .btf.uapi_header_guards"
>>>>> +    fi
>>>>> +
>>>>>       vmlinux_link ${1}
>>>>>       info "BTF" ${2}
>>>>> -    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>>>>> +    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} 
>>>>> ${extra_flags} ${1}
>>>>>       # Create ${2} which contains just .BTF section but no symbols. Add
>>>>>       # SHF_ALLOC because .BTF will be part of the vmlinux image. 
>>>>> --strip-all

