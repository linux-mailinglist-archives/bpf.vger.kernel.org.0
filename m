Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE423538E5
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhDDQqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 12:46:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229861AbhDDQqD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 4 Apr 2021 12:46:03 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 134GjsRU017860;
        Sun, 4 Apr 2021 09:45:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=l7aG4N9Xb8XbHma0F5XR3Gg24/qvuCSXP/nQ24cSnYE=;
 b=UkUqTtDL6KDKkhGfAlOpdoOtscCq1gXJUv1+g3XPUDBQPLC9N0xmqsm5bRmV6KAsz+Bx
 AOusUYY2ActJbVUeQQYZrpQYMdzCD/3lrRyokF7uVfy8OW/oJxOxWnMn8uBjn42Xj05B
 Q8C4GIybJQrZnkHInKnv4EBlMY5itlXXDw8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37qgk10481-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 04 Apr 2021 09:45:55 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 4 Apr 2021 09:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+a3mCTegv5Dc3dARYmJhL+t7WSsvRJPtg/vR67iOyAmC0tIzlax+uqqsHPnKgP43DcGzrCSV56C6YYsMwSjzyQr9rGB7vrvTga/9NtWSLJIaReb3kj7KQ39KO0x87sKAatXVkdU2KAhYyXwBq0nmQP1cfKp5TwTu7jgvqAxE7CfT0tQ/+eJSPoNJ6UdM4qifUJGx8ZJ9mbvG2XMRciOIBqIB+8jAIvNm+MHx5UWGFRi7zPb1v/e7wWyLXCYzc0x3Cv0Spmpuah5HEbkGsnwz5+uHOt8y8KtMD6svByq4QdayRrHZT3o4zQXm2aQ4pz7BRFve3DVz5wCfIVS7hG5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7aG4N9Xb8XbHma0F5XR3Gg24/qvuCSXP/nQ24cSnYE=;
 b=lNE/KoJYl1M0ePV8E9bsn6L6bgYMxnsA+a+H4cLNFdNCyKcZtENwKl9LNeue52gfH9l/Y1vtsfpg5YshIXuCiDS6SgqZqOhCvQlvJYe4bL2nykBelF+4oq6FhpZi5hBJCd4rmaW/jH1jlofKP6qYtw+vW5xgOJ5hCBPe8+N8uJL2fzdDW+EL9oAlYF1S2wwSx8roqqepRUzJnZChrQAFBIdQ743jDPDSNhFvCjnn/78O1G84j69bQLeEYBBz4Uy8Gdj7rqFQrFqSW9xF9XrRV6R39NNyNVYo0koEYtLCDHkY2p6PPvq8JxBPzUhsVaHZYT2JmFgUGUE2jHzxeAuR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2286.namprd15.prod.outlook.com (2603:10b6:805:1f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Sun, 4 Apr
 2021 16:45:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 16:45:46 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210403184158.2834387-1-yhs@fb.com>
Message-ID: <d4786dab-b35c-c8f4-a848-3fc9f93228a0@fb.com>
Date:   Sun, 4 Apr 2021 09:45:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <20210403184158.2834387-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c996]
X-ClientProxiedBy: CO2PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:104:6::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10a5] (2620:10d:c090:400::5:c996) by CO2PR04CA0090.namprd04.prod.outlook.com (2603:10b6:104:6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Sun, 4 Apr 2021 16:45:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb04c0f7-ea98-4ab9-083c-08d8f7891865
X-MS-TrafficTypeDiagnostic: SN6PR15MB2286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2286BE587FE1FB3FF1828649D3789@SN6PR15MB2286.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elI1udykc/vL2lThHzVIMhBAzy3hYt3LFclBCYQ9T9qCzm208ef8uH9MiBZqB7A0femH2Rr+t8qOh7aWYKLebZpUSUDoDq3UB8s+CFnfZKoMZ9pWeR0WXwoWJLgFcsTPnGBX6jt2pO4GEzEl+XeclytEPxh/xPVTmi5ikJuABSwIQk0YU70NAp26ld/ia5syaiZ84wwcRQs3TpfFZ1w6LVzQWu6lgpIHFUXTpYAlWjZYR/Q0sF1NybDf43IOp2YehwY+Ksb15auUO5tk0Slj+rMwvUNTW3q5UBooEfkLYvHp95nSfjCKqoJO0bknDsCHV7lXwZc+rhldriHp9WwjY6XHd3cWjRDlho9wrI00zPaV+MwHgTQv7vFrzr2YD3FtZ4d+Bnxs49sHdw3lcC546rUtms3HpIw4ce7kDtx7l76pyQWMLLSehnmAjtshNjNlC6qhDRzBHSiKw2yfdPgNLPMqEqLiHnEl6aAhKdN1gAJNSU/MtXbxSRRysuQeda24mN9YSXjSYMJLOsmUWbbwhbXu5fd+cLNoyJF3wRieu9MNYsJ/p0Tjg6w1s6uPS9XlpFJGk5+0St2T5UEb4TxWIWIWJDm+oZokIRHRU4vPJ+6Ynud9Qee0l7s5giIVtMnVkQdIALhylaPdWY3xLc+9rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(86362001)(38100700001)(54906003)(53546011)(31686004)(31696002)(4326008)(2616005)(316002)(6486002)(36756003)(66946007)(5660300002)(16526019)(66556008)(186003)(8936002)(2906002)(478600001)(8676002)(66476007)(83380400001)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjhuL3RpZi9nNE84aUJNOGFaQzk0TVBoZEVIMUs4ODRSMG1ScktlVzBXMkZJ?=
 =?utf-8?B?cktoeC93OEFEc1VDLy80WEh5R0JrN21SYXczTjlGTGNsbkhNUVdkTDg1YmNk?=
 =?utf-8?B?elhxVUQ0dTV0djdKanUzTmx3d3R3TDF0TmNwMndwM2M3b1QrcnZKblJFaFRJ?=
 =?utf-8?B?dlRKOXo0dDljOTIydTBpVnRTdHBvYW1HL0xER1Q2cGZlVTFLUGdBU3hkWitR?=
 =?utf-8?B?TUV6SWhuNDF4THkrU0xZUmZ3bUJSS21mNlJBRU54a3EwUE0wMWpEa0lpSlFt?=
 =?utf-8?B?bVlwaVdwMlFjOUFPamVkSnRLdjJLWEFyNTdSRUdrWEwwRG1HcDZSbzVoVlNR?=
 =?utf-8?B?VDJMc1lPRCtjOG04M0hrb2JVRk5kY0hxeTQ5dHZBSFg0cEVmb0NMaG1PdmVx?=
 =?utf-8?B?eDU5SWluZjZTM1lTeElERklXSmMwS1dIMkpXRm1EcHpRV0tzcmN5eUlZVGFx?=
 =?utf-8?B?M3RQdE1mVkF6UWlSR0diSk9laUhWT2dhNVR3bGZrNTRud0N0MWx0OENPSW1k?=
 =?utf-8?B?NXZXTU1GM2dWNFd6S2JmdGhOMEVmUXhITllaK1cyblRjRnlBQndMdS9CaTRF?=
 =?utf-8?B?NDU4ekMwZ0dobXE3a0pQbU5Ma3ljUVY5blFaczBZVmxaQitneTFsOHhNSVFo?=
 =?utf-8?B?Q3pSMHZodzNITDNNbkNCRFNsMFhWU2tJdFI0bDcreDNyd2gvYkhjaWJ3bkxu?=
 =?utf-8?B?S0gzSENraDhyNDVaazJMbCtxd2F5Y0lBVXlCazhxVEtpVXIxY2Z2SEZObGRz?=
 =?utf-8?B?MzRNaHROaUdDVktnMFVZbTYweGpHMUpQT29UMEkxSVhCTk81a2NNQ09MNWRD?=
 =?utf-8?B?QWo4L0tJQlVHTnUxNGVPMkJZVzU2cmY4WWYvRStoSmpPUUF6eW5KTjBkMFho?=
 =?utf-8?B?VUhuQzVYczB0enB2Znp0cnNLcTBPcEJQSElKVVE4NnNsRjRyQ0JWUTdOTXQw?=
 =?utf-8?B?UEJqNmMwM2tmQWgyTVh5OEJMUG03ZWcxUkhQV29rTis3RGxtQnp1akJremdz?=
 =?utf-8?B?Z3lFeFVmeGloMVNwV2FxUk42dy9RRm5tZnZESEJYVCtuZGs1QVR0WnF3endK?=
 =?utf-8?B?M3ZuUmU5LzdaNDNUdFVVS2NJcmFwTzFBUWNxcFdSKzhBcHErcUtISWtqSlRv?=
 =?utf-8?B?SXY4U2xYU3FCdHJZRlE2bWhwZDJMRk9WNHNweWwyUCtMdkNiSmlMSGtVOXJj?=
 =?utf-8?B?ZTZFaVBnL3NkQjNYSjBTbGF3MW5RQStSNjZtRlZlSVM4MFFaK3RnMlFOUkNY?=
 =?utf-8?B?UWo2T0xhR1plV0NPd09FTGltUmN2NkxZVEhISEhaNDRWbXlmcDByZnYvRFdQ?=
 =?utf-8?B?MEFyaE1YTlBiRFZvV3FLaFUyVHZTa3piTFJnMmg1ZlVHeE1RRm9STWZLU0wz?=
 =?utf-8?B?eW1FQzZHaWlOekw4bTYxSGNqODBPQ0hVMHM2bDdIaExYY0NHNmIveUtrQVBK?=
 =?utf-8?B?cXBaL21TbUVSQU5kWURVTTIrSUdnOTBNUVMzNjRsZkNVVGtOWm9ib3BqbmJX?=
 =?utf-8?B?YlA0NW5nRVA3ZzhqNkdYSWtYTGhzK3BHWGdqajZ2QmlaRHRFTHN0RHZyWU5J?=
 =?utf-8?B?RnhKWG1kOFZ6Nm1BOFZaU0haQU1kRVQvMzRaVHRKSnR1cEdXL3RIbHFZY1B5?=
 =?utf-8?B?UDc2L0JiUlJXUjFFKzZSWnlLczhBUWdmdUZINmw1bTBSMnpLb2hJdWhRLzBz?=
 =?utf-8?B?eVdmUlIzR01RM2FlV0VhTUtVQTF2SjV2a1dlSkRGWmdDZ1FSK1BOYTF6c1hT?=
 =?utf-8?B?THJvV2xNWnloVnFnaW5mVkRHZm1uSllsWjcxaUZmQitEcnB4K2Q0ZlVxOEhL?=
 =?utf-8?Q?hrLWWU7ns/rvzXnJZkEE+Uw3MIwtnemaGmDIQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb04c0f7-ea98-4ab9-083c-08d8f7891865
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 16:45:46.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC+5iCd6c3zswThSr9HCSDCH+EiTC+Wvcbz5nQxrVRqpMHsmM+mBJCAyfXnaNLwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2286
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 456W99ZTci9CvOwGsjVcsxSu0gqolGVM
X-Proofpoint-GUID: 456W99ZTci9CvOwGsjVcsxSu0gqolGVM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-04_05:2021-04-01,2021-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104040116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/3/21 11:41 AM, Yonghong Song wrote:
> Currently, when DWARF5 is enabled in kernel, DEBUG_INFO_BTF
> needs to be disabled. I hacked the kernel to enable DEBUG_INFO_BTF
> like:
>    --- a/lib/Kconfig.debug
>    +++ b/lib/Kconfig.debug
>    @@ -286,7 +286,6 @@ config DEBUG_INFO_DWARF5
>            bool "Generate DWARF Version 5 debuginfo"
>            depends on GCC_VERSION >= 50000 || CC_IS_CLANG
>            depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
>    -       depends on !DEBUG_INFO_BTF
>            help
> and tried DWARF5 with latest trunk clang, thin-lto and no lto.
> In both cases, I got a few additional failures like:
>    $ ./test_progs -n 55/2
>    ...
>    libbpf: extern (var ksym) 'bpf_prog_active': failed to find BTF ID in kernel BTF(s).
>    libbpf: failed to load object 'kfunc_call_test_subprog'
>    libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
>    test_subprog:FAIL:skel unexpected error: 0
>    #55/2 subprog:FAIL
> 
> Here, bpf_prog_active is a percpu global variable and pahole is supposed to
> put into BTF, but it is not there.
> 
> Further analysis shows this is due to encoding difference between
> DWARF4 and DWARF5. In DWARF5, a new section .debug_addr
> and several new ops, e.g. DW_OP_addrx, are introduced.
> DW_OP_addrx is actually an index into .debug_addr section starting
> from an offset encoded with DW_AT_addr_base in DW_TAG_compile_unit.
> 
> For the above 'bpf_prog_active' example, with DWARF4, we have
>    0x02281a96:   DW_TAG_variable
>                    DW_AT_name      ("bpf_prog_active")
>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/include/linux/bpf.h")
>                    DW_AT_decl_line (1170)
>                    DW_AT_decl_column       (0x01)
>                    DW_AT_type      (0x0226d171 "int")
>                    DW_AT_external  (true)
>                    DW_AT_declaration       (true)
> 
>    0x02292f04:   DW_TAG_variable
>                    DW_AT_specification     (0x02281a96 "bpf_prog_active")
>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
>                    DW_AT_decl_line (45)
>                    DW_AT_location  (DW_OP_addr 0x28940)
> For DWARF5, we have
>    0x0138b0a1:   DW_TAG_variable
>                    DW_AT_name      ("bpf_prog_active")
>                    DW_AT_type      (0x013760b9 "int")
>                    DW_AT_external  (true)
>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
>                    DW_AT_decl_line (45)
>                    DW_AT_location  (DW_OP_addrx 0x16)
> 
> This patch added support for DW_OP_addrx. With the patch, the above
> failing bpf selftest and other similar failed selftests succeeded.

Arnaldo, sorry, I just found that I forgot signed-off. Here it is,

Signed-off-by: Yonghong Song <yhs@fb.com>

If no further change is needed for this patch, maybe you can help add 
it? Otherwise, I can add it in v2. Thanks!

> ---
>   dwarf_loader.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> NOTE: with this patch, at least for clang trunk, all bpf selftests
>        are fine for DWARF5 w.r.t. compiler and pahole. Hopefully
>        after pahole 1.21 release, we can remove DWARF5 dependence
>        with !DEBUG_INFO_BTF.
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 82d7131..49336ac 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -401,8 +401,19 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
>   {
>   	Dwarf_Attribute attr;
>   	if (dwarf_attr(die, DW_AT_location, &attr) != NULL) {
> -		if (dwarf_getlocation(&attr, expr, exprlen) == 0)
> +		if (dwarf_getlocation(&attr, expr, exprlen) == 0) {
> +			/* DW_OP_addrx needs additional lookup for real addr. */
> +			if (*exprlen != 0 && expr[0]->atom == DW_OP_addrx) {
> +				Dwarf_Attribute addr_attr;
> +				dwarf_getlocation_attr(&attr, expr[0], &addr_attr);
> +
> +				Dwarf_Addr address;
> +				dwarf_formaddr (&addr_attr, &address);
> +
> +				expr[0]->number = address;
> +			}
>   			return 0;
> +		}
>   	}
>   
>   	return 1;
> @@ -626,6 +637,7 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
>   		Dwarf_Op *expr = location->expr;
>   		switch (expr->atom) {
>   		case DW_OP_addr:
> +		case DW_OP_addrx:
>   			scope = VSCOPE_GLOBAL;
>   			*addr = expr[0].number;
>   			break;
> 
