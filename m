Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF68403100
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348635AbhIGWZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 18:25:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348992AbhIGWZg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 18:25:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187MB4Yt007211;
        Tue, 7 Sep 2021 15:24:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oe0BB7g50c2xuSTURolS+YetLZZqEIrsaNnPRl4077E=;
 b=kqqSCoDpRZpmTdMz1whji+gtVEFUvkQuhvD004ovCgvE+oia2KLSsaPxCqMGHxHzck/b
 FH/96VWCv5r8y2uu6OqP5ME5CEkyNcKHsYIDT4LeaLUwGTq+P8FDCI1UW1l/xdUyabvi
 awZGPLXfd/t3lcy3fzAMoqqi8yzHX6eEG7o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcmw1n08-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 15:24:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvaTIAX6WLhlwMDH5zfBfPooNf4BrF0FqlYH5HrDoFFVvV0eRNVt+UkgNuGPcGWOAAqBQEPXZkrAQf2Kv4HXSALzEC/ltLm2KI9ycNCPyNYPTdGXYrWkuwHHL0rZFQC8/qygdM+0U36vKo3Ib2Ztv4NlRBw3lRL/IVSn5f31iLevoEkzAjvFuH/GxBu2T+jxGD894OMGx6aytq2+FTYneyroFrfKRM56DOyWhn4NvYIQq9nHFIPoGMqm20CSBgbVyZO0Lt5WfonoNmAEKYErekpWLSiRoFUTIdbUWa5JOiKVGDZpccLTdYJvvRFPHQCN/mGytUX/sdpGECWcTW1n+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=51eQPcyEAsgErL2K8etgGIlwFo1GM3Co3rPtkqshYuU=;
 b=Ibv/YrilZZQVet5Q2RHg1fZmYaznDSNssGhVnATo9ll+FD0XdFT2VPTDKMLdApf8FEId5D0szJ7lhUZWnBQjKVTeHIzCrj53DcMdfWVuhxNQ1pBzIuxPkNfRSpUBFv/hnhqoTABVN83EzGvljWEAeuSxjpucPEFSDkYTaLiouFP+G+Ypqtn72+ZEfW/DBA2OBaBoWT50Bkr+NeR4HeJniA8nmP5vltdn0Rjq0N+pweA+6FQghxYK2OIZ1RxYbUuqqTimOIl7i70BOhAzPAFphIRAb83RYRJaZfrBVdb4LYtJ+BU86xc920OCQrfxTVisJjM0EszgWQEMMR8Fo/O4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3965.namprd15.prod.outlook.com (2603:10b6:806:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 22:24:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 22:24:08 +0000
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <20210826120953.11041-1-toke@redhat.com>
 <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk> <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com>
 <87wnnysy6k.fsf@toke.dk>
 <CAADnVQKYdjFR+LvnQFdKF=TJ2fSRdG7B0L+Au9KchBsV+dCr5w@mail.gmail.com>
 <095f116b-7399-25a5-dca2-145cbd093326@fb.com> <87czpqskac.fsf@toke.dk>
 <0426a8fb-ee42-cbcc-65e9-45654adf5948@fb.com> <87fsugp48q.fsf@toke.dk>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3bbe1fae-617b-4d1a-8c29-2579d19cd5fb@fb.com>
Date:   Tue, 7 Sep 2021 15:24:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <87fsugp48q.fsf@toke.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e8::18c1] (2620:10d:c090:400::5:ae51) by MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Tue, 7 Sep 2021 22:24:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26779052-1186-4aa3-d5bb-08d9724e35d8
X-MS-TrafficTypeDiagnostic: SA0PR15MB3965:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3965D674BF283D6FA3477502D3D39@SA0PR15MB3965.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBbveSkGR5G/7oAeL88x8RojuNl8REAnjoEG7YjFIL44538zEOh56U0rdJtcjVLtqn2XfKo4KWN6U4fvyIWvdK0JHbyNNPSq4ibbmzHUzmqMvqKb1Xq4HFdbRCxZFR1qbdL0+NsQ6KCPv1oedHfl33ndSez6Gbk35GHRMIDJcTKg1GVI+JvUvQAWCLaAaRonYGzme+hbccTbfEptaWzSWoYn2W53dxHZV9I6kKxzMHUTdwH1VXDUtwRAGySkrsA31N/tKHkxZXYS7H/IpB+Qw8lcoGJqaLIKyo8CX8s91V4AwNWMUxid/CtGPhUmJCjDteSS0KEH+vpZYsBmSNXRAjbH92oJ2+lyqHDzCqrOeUdF3AEwwXiQjLtKo8v53HAdA6AjU431tPPWfKR0IrFzpEj2ACdlrEi45qI4cLC5DHLCkBxqaonHIssmMfkJsAOMcXJi45bJcVEP/6OyllJJfg+fTiFanEvJ4iDkr5HOzgblFg2gxk91PPGocmIKb1dE8jsZyC96yB7NBfHtSsqtfr4l7ZvkKhCDIEMMaL6RIaoHLfbWFLk/Ey78/tyHVdjckRW7woBF+GKYP5zHjCprqIfV477QEuU3YmBzsH0GCoChqyeH+7LZ9uoJqmAuMYQm9zceMAK61vc99m4nwDiAhR0TPKB7ULDyvLPOOzVJKHL6184TNYcFwtFIr9BOhtPtOEvEac8S6OgUR+GCDJSYRK3Yj+6jr4UPlOl4jgAaLjLeJ+C5LySPx0eUqxJVfdhptBlq2PoHVgTY0vt3/1KCbitGCNiJBRZYPCkWNs9DqQRkPRYCstBxCi8SLTVmCf3mHTxSLZzOdMM9rlKn8v+ock8qnf3cmWJmaiZmBr42wkpn0UCMLRbov1jJ2F8Foz1f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(31696002)(2616005)(966005)(478600001)(5660300002)(8936002)(4326008)(66476007)(38100700002)(66556008)(66946007)(316002)(6486002)(86362001)(31686004)(110136005)(54906003)(7416002)(53546011)(83380400001)(52116002)(36756003)(186003)(8676002)(66574015)(2906002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tLNEV5eXd2d1lzVjZsOEp5L2d6Um9Ld1doUjlrQ1VFT0duOTVWVWMxaHBM?=
 =?utf-8?B?dUhCUzRyaFFGOGlyUjF0b1dmTXVJMGluQTJOL09rUjZTcVZJNXdCV0F6RzVN?=
 =?utf-8?B?VklkOTd4bTJ1UXhhWG1PTXUyNS93bXVMVUE5K3U1MDhkZTg3T3N6Q1VpQUpk?=
 =?utf-8?B?Qm1wWEJuR0h1WUlDYm11VmppWE5ySGxRMHJ6SmdCSExIa2U4VndadWVxY3VD?=
 =?utf-8?B?M2kvQUFPSzlDbERXL2hoVkhYZ3kxZElYejFHc2w3WmdEMld5MjJ3NXlRZzRZ?=
 =?utf-8?B?YnNUQzg2VVNMQnNWeDN3Qy94RjBPUGFEL3hlT1FpeXhxdVZ4TW9IM0FHd1JS?=
 =?utf-8?B?cGdCQVBPck9ibVFlYk1FSEh3VG1aYmp4eStwSVJFTTdSdHpHM0kxa3YraW8y?=
 =?utf-8?B?cGpleEJjNXRiM2VYaEduR0puWDQxblBrMjNjVXZXRHF3WW5JdmJNL0xKREh4?=
 =?utf-8?B?eDFBY0hGYWFwQTBraEs2aFFXUXltL2wybkkvbmZxU2VHTjVZazBFeStRWGhQ?=
 =?utf-8?B?RWJuRXpzaE1wdXVRdzZEL09ORUdsU2tNbjIzdkhUdHplTWkzRGw1N2RTNkMx?=
 =?utf-8?B?Tzg1NUhySHl3S09xTlpObUJLY2V5bmRlcGFGVEZKY01rbk1IblNocHZFZmNh?=
 =?utf-8?B?WGZCdXVOdXhxd3F1cGFkclV5WEZpQlFjK0lSUG92SHVIOGFNR1EzTjJaYnJy?=
 =?utf-8?B?R2lqNTZEYzRJWTVDeGhnLzdzYllDc0diOVVCcWc4M3ZHWUJvYVFvNmdsZElk?=
 =?utf-8?B?UXdJbkdwcWpBdWE3NmpMWmU2WTZZejlxRk5kdURHNU5VUVhEVFVINzhIbzRC?=
 =?utf-8?B?ZWNQTDVjckJHejIyWnpscjVpSEM2TTJaM2M2dzFGRFJtQjlZd3RrSmEvM3dZ?=
 =?utf-8?B?U3o1dXBDQ2xIajQwZndVdDhBMndaK2pZSlljRXR1YnJXOFFXTnJUSUsvNTlt?=
 =?utf-8?B?ck9DKyt2enMzMUtjY2xzb2tkK1IzbkdhVVBBTUZSdUJxUlIrYWJ6WE1aQXJj?=
 =?utf-8?B?NWFtTGV5ZXVETG5ST0luTXJhUWduQThFVGpwWThJYlRteGQ5cW1wQXh2SFo3?=
 =?utf-8?B?TkVBem9XMWhvSzd5NkJzdlZmSE1Gd05pNUJ1YmpsUzFCcDZJR0VDcHFnUUJn?=
 =?utf-8?B?TWJ2U3RXb1hkckhINEFySkNiNXdoRTZFTThGL3h2dkFodFNZM0lFdEprK3FV?=
 =?utf-8?B?SWlXNDljUHZ2eGpMaGhoK0VCZGFZS0Z6dmpTZmR1blJvZXllMEZ5Tk4vRXp0?=
 =?utf-8?B?RForVkRuejM3YVhMbVBIOFVESEtvS2d3aWlDMWwzSnZTK3Bud0lyMU1kSWlo?=
 =?utf-8?B?SFJEQklvdHltTnpqRVU2ZDhaYm5pTlk2Q0lWREtKZVZkTUl4YmI0WnJLMEti?=
 =?utf-8?B?ZGlpUTN6QmJQOGJWZ2pSNE9JL0poS2RLcko3Y2N2aHk0VVU3bkxXcXpDOTZa?=
 =?utf-8?B?KzZSLzhOWDhnT09rMTdJMVJKZnRRUVg3VVg3Mm1LalJYVndod0x5SUw2MDh5?=
 =?utf-8?B?TDh1QlZkNXpvb3JwRytiL0E2Q282VEp3SEd6eUNuRTAvdUJjam5wakIzbUd6?=
 =?utf-8?B?TVJsQjlvbTZYa1grY3BEN1hmZFNKT2pGVkFFN0ZvNkIxSjVRZ29VQVVla2FV?=
 =?utf-8?B?Y2I0aG5PMFFUZUNKTm5KQ1NiZW9GVmR6L2xTK0Vadm1pbkxTRFMzT3VsRHB3?=
 =?utf-8?B?bFVhdjVHYlo1UHdPV3B5cmNyMW5nOWoxZUYvYmM2ejhIczlLRWJCSEd4WWRD?=
 =?utf-8?B?YjRhSTJ2SCtLZHRzOWZZMWI4STJhaEZuYy96cDI5NUJWb3pRcFdFaXdRTzd1?=
 =?utf-8?B?U2pwQ0ZEWHNFM203WUNGUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26779052-1186-4aa3-d5bb-08d9724e35d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 22:24:08.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJ43F4nhxBdxVsx4Mmou2/yzFzRB91LStskKQVAM70/SaGFtfsQaPNIUtLMDgoz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3965
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ULv1ert-j9X6ctKSlEqSWswisDOPHAiZ
X-Proofpoint-GUID: ULv1ert-j9X6ctKSlEqSWswisDOPHAiZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/7/21 12:36 PM, Toke Høiland-Jørgensen wrote:
> Yonghong Song <yhs@fb.com> writes:
> 
>> On 9/2/21 3:08 PM, Toke Høiland-Jørgensen wrote:
>>> Yonghong Song <yhs@fb.com> writes:
>>>
>>>> On 9/2/21 12:32 PM, Alexei Starovoitov wrote:
>>>>> On Thu, Sep 2, 2021 at 10:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>>>
>>>>>> Yonghong Song <yhs@fb.com> writes:
>>>>>>
>>>>>>> On 8/31/21 3:28 AM, Toke Høiland-Jørgensen wrote:
>>>>>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>>>>>>
>>>>>>>>> On Thu, Aug 26, 2021 at 5:10 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> When .eh_frame and .rel.eh_frame sections are present in BPF object files,
>>>>>>>>>> libbpf produces errors like this when loading the file:
>>>>>>>>>>
>>>>>>>>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>>>>>>>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh_frame
>>>>>>>>>>
>>>>>>>>>> It is possible to get rid of the .eh_frame section by adding
>>>>>>>>>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
>>>>>>>>>> multiple examples of these sections appearing in BPF files in the wild,
>>>>>>>>>> most recently in samples/bpf, fixed by:
>>>>>>>>>> 5a0ae9872d5c ("bpf, samples: Add -fno-
>>>>> /to BPF Clang invocation")
>>>>>>>>>>
>>>>>>>>>> While the errors are technically harmless, they look odd and confuse users.
>>>>>>>>>
>>>>>>>>> These warnings point out invalid set of compiler flags used for
>>>>>>>>> compiling BPF object files, though. Which is a good thing and should
>>>>>>>>> incentivize anyone getting those warnings to check and fix how they do
>>>>>>>>> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
>>>>>>>>> object files at all, and that's what libbpf is trying to say.
>>>>>>>>
>>>>>>>> Apart from triggering that warning, what effect does this have, though?
>>>>>>>> The programs seem to work just fine (as evidenced by the fact that
>>>>>>>> samples/bpf has been built this way for years, for instance)...
>>>>>>>>
>>>>>>>> Also, how is a user supposed to go from that cryptic error message to
>>>>>>>> figuring out that it has something to do with compiler flags?
>>>>>>>>
>>>>>>>>> I don't know exactly in which situations that .eh_frame section is
>>>>>>>>> added, but looking at our selftests (and now samples/bpf as well),
>>>>>>>>> where we use -target bpf, we don't need
>>>>>>>>> -fno-asynchronous-unwind-tables at all.
>>>>>>>>
>>>>>>>> This seems to at least be compiler-dependent. We ran into this with
>>>>>>>> bpftool as well (for the internal BPF programs it loads whenever it
>>>>>>>> runs), which already had '-target bpf' in the Makefile. We're carrying
>>>>>>>> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
>>>>>>>> bpftool build to fix this...
>>>>>>>
>>>>>>> I haven't seen an instance of .eh_frame as well with -target bpf.
>>>>>>> Do you have a reproducible test case? I would like to investigate
>>>>>>> what is the possible cause and whether we could do something in llvm
>>>>>>> to prevent its generatin. Thanks!
>>>>>>
>>>>>> We found this in the RHEL builds of bpftool. I don't think we're doing
>>>>>> anything special, other than maybe building with a clang version that's
>>>>>> a few versions behind:
>>>>>>
>>>>>> # clang --version
>>>>>> clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+8598+a071fcd5)
>>>>>> Target: x86_64-unknown-linux-gnu
>>>>>> Thread model: posix
>>>>>> InstalledDir: /usr/bin
>>>>>>
>>>>>> So I suppose it may resolve itself once we upgrade LLVM?
>>>>>
>>>>> That's odd. I don't think I've seen this issue even with clang 11
>>>>> (but I built it myself).
>>>>
>>>> I cannot reproduce it by self with self built llvm (11, 12, 13, 14).
>>>> But I can reproduce it with an upstream built llvm12.
>>>>
>>>> /bin/clang \
>>>>            -I. \
>>>>            -I/home/yhs/work/bpf-next/tools/include/uapi/ \
>>>>            -I/home/yhs/work/bpf-next/tools/lib/bpf/ \
>>>>            -I/home/yhs/work/bpf-next/tools/lib \
>>>>            -g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o
>>>> pid_iter.bpf.o && llvm-strip -g pid_iter.bpf.o
>>>>      GEN     pid_iter.skel.h
>>>> libbpf: elf: skipping unrecognized data section(11) .eh_frame
>>>> libbpf: elf: skipping relo section(12) .rel.eh_frame for section(11)
>>>> .eh_frame
>>>
>>> Ah, that's interesting!
>>>
>>>>> If there is a fix indeed let's backport it to llvm 11. The user
>>>>> experience matters.
>>>>> It could be llvm configuration too.
>>>>> I'm guessing some build flags might influence default settings
>>>>> for unwind tables.
>>>>>
>>>>> Yonghong, can we make bpf backend to ignore needsUnwindTableEntry ?
>>>>
>>>> Sure. I will try to get upstream build flags, reproduce and fix it
>>>> in llvm.
>>
>> I did some investigation and this is due to centos private patch:
>> https://git.centos.org/rpms/clang/blob/b99d8d4a38320329e10570f308c3e2d8cf295c78/f/SOURCES/0002-PATCH-clang-Make-funwind-tables-the-default-on-all-a.patch
>>
>> In upstream, the original llvm-project source is patched with
>> several private patches before building the rpm.
>> https://koji.mbox.centos.org/pkgs/packages/clang/12.0.1/1.module_el8.5.0+892+54d791e1/data/logs/x86_64/build.log
>>
>> The above private patch enables unwind-table (.eh_frame section)
>> by default for ALL architectures and bpf is a victim of this.
> 
> Ah, doh! I had no idea we were doing this :/
> 
>> I filed a redhat bugzilla bug to fix their private patch.
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2002024
>>
>> Hopefully future newer compiler build won't have this issue.
> 
> Thank you for finding the root cause of this! I'll follow up internally
> and make sure we get this fixed...

Thanks! Hopefully this can be resolved soon.

> 
> -Toke
> 
