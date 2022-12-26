Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647BE656179
	for <lists+bpf@lfdr.de>; Mon, 26 Dec 2022 10:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiLZJih (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Dec 2022 04:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZJif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Dec 2022 04:38:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6346FC6
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 01:38:31 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQ5nR3w011639;
        Mon, 26 Dec 2022 09:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3bvw2oSLexaNWjfsUIHFhKv7G304WFhU9SyEsuIclN0=;
 b=yG4Y+BCyMDBU30Oh5uzn436mzXbN/qbhyETLPZcAWi0pYdRdy97aFRgDGotNf/m2GhxY
 4rvGXzSdsgU3+/fFcIZjRP7k97rZTlNZnbERPxgqHq/tyKjdIFWh4ciqng3Q8xxK+nuS
 vxHcZww0/yd2QmO/9qENmccQHOJCucLGFftjludF8K6/lYmUHGT0bP+oU27tVD9OdKxa
 0TC9Ac+sexnhvJe8cQ2t3hICFKWUKzXdWjdp8pm+eYTfaCzoOrs3ihuAbAEXSHgHQkTw
 9pFyu5fOBCoBc12aihHr1Gm2QZYtwG6JKCY/PvHNWxcvZz8WQQPoCvOUktEulY4+r81D VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mnrbb26he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Dec 2022 09:38:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BQ8JYWd020360;
        Mon, 26 Dec 2022 09:38:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mnqv3yd8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Dec 2022 09:38:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEC2BFwBl/fBGiZMVAzOkR9P6xK6lRUUvJPk6OUV4np+lUDFp/tI+8QUKtBF4UP11tVacT83Hy0ngA//Hvg70cZTV8EQ/X0xyjwnsigSOIf+HY6TG9Aq1WxkoC6uLgu5vHZIrQ1ybaQCtQsad4llCCtSJJHZGJFRxz/X0JBF1A7BZfWZQDL2bdGrM2WyLpcrPBu6OgVOHKpWsLlZ9Mjv2Apu1kONXJZ8Zlv1y7kGGj5vNyhwBiHRl4LbzCr5grnjbuMXyPTDQQ84ZjMF6nKrvOvaw5I1lUf1SQZqAHSh4Il7iqRDVbrDLh/MhbCI4Oi79IvhnIHYermHoXzAMZoQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bvw2oSLexaNWjfsUIHFhKv7G304WFhU9SyEsuIclN0=;
 b=NMLVMWJHI/1Dmhq45Ail6qrfUHHcJb7b7yPnFb8vGTnKHC85q8kblmLcjsESwctyqbgZCfSPc2fBZEipYi25l9z2Hf0UyuOsgPun76v1sLHRegaQWVATP7UlY76aZsIkJd0xtJeF43EYj2UjQbZnjreQS5tvP5XJtz6/Ej1JRR9Xz+nrFeP0XvtJCkJqJcMQx5K8+gfYMfDc3gJrGVZvIW5C0wQAGeahHuXFFOwDWQHChoT4QuEgLGd+CS6xl9a+1pcypcdFP3J2c8xSaPLGwYrqI2gxGHPd83EpdiBYgEExVSnd00CuyLE2EYwyMWiXMORl6aJI1aJ/1gIwuz36Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bvw2oSLexaNWjfsUIHFhKv7G304WFhU9SyEsuIclN0=;
 b=bP39HX/Gh6xCqoqh/kJWa+cnrwrJvRmM9nvx6ESDEJKtkORrCTYr3Axiy6SCo0MyIigp2+myq58AjAgM9X8++3p6kmcnxObCZbadbf0Oaj23h4jcEElQS9+awjZieCfflAParPDmR8WTxURH36FBGlJiuW2tv/z/f4oytGTmMOM=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 26 Dec
 2022 09:38:27 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5944.013; Mon, 26 Dec 2022
 09:38:27 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     SuHsueyu <anolasc13@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Support for gcc
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
        <871qosy5u8.fsf@oracle.com> <87mt7gwqx6.fsf@oracle.com>
        <CAEc2n-t1W5uit+S9FkttdvbLhZgRdX2-RzUxw71X9FyptsdaSQ@mail.gmail.com>
Date:   Mon, 26 Dec 2022 10:42:34 +0100
In-Reply-To: <CAEc2n-t1W5uit+S9FkttdvbLhZgRdX2-RzUxw71X9FyptsdaSQ@mail.gmail.com>
        (SuHsueyu's message of "Sun, 25 Dec 2022 23:24:08 +0800")
Message-ID: <87pmc6xzzp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR0P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::14) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e49082-8ed2-4ed3-391c-08dae724f098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzW0PnC3427YOtPpVQUsKKsCYw8s2qtl/6S7sbsS/gj2a5jtP+//naHq7JNq61ErawzHa0Vci2cKjQceRYlb7Iu3OUDGZUetTPt5I8geHfbZU4y/eQk1HCeHMW/N2ZRMsxOrytIYNWVWZzuJ5foo6kNy5g8GypgDZLy1y5aeqdFgZyQNhbYLaHov+gflKHhph8icBLhyUgexKofZ1UyV8RxYpBAPKghBL/y10LtFcLukPM0gNkd1Qfcity0sPKfE6cNxvHrLfA7WLgkvBUt9pXFAUS3z6PoGAtq2/lD9/SAOl3h2SQS7mSz280PAaV/aDbWfBkaL1Ley9v33inDcz2IUHKgIkal3xAL/fm7en7qMdMfhI0E0SbQ54+TpDjp7B05Cr/fQDUxX9UgOhTiIJXxFeX8L+0yHHC54a8FFhm1xQDcpMPgYs9qm1yJnSs+/cQ+7Dpa63wwDMogZMArW9TSch4iiTUWq8ZPo9fPSoLzBFkOLXL6nwtslt3gUsVNFM+TOpGa7KDm2TYsHtEd3uH5cznQTClGmLlDNma0QU8sLG6KtiJvdwDuierG0vCt74fF6vS6g08fG4ePnZ4CresImVGyjZsmm6BID3ECEH/DyOM5RRvXCZv8y2d21XvrAcVSXhjDZGRIlnWWFNZ8176aSuLqMM0/Oz/cIuo/93g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(478600001)(6486002)(966005)(316002)(6916009)(36756003)(2906002)(3480700007)(83380400001)(38100700002)(86362001)(6666004)(2616005)(53546011)(6506007)(26005)(186003)(6512007)(7116003)(66476007)(66556008)(66946007)(8676002)(5660300002)(4326008)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFIzZUlaeTRVeFBoRXdFRkhZUmJwM0s5N3I0Y001WE9hQmplRFVCVk5SUi9Z?=
 =?utf-8?B?dUNYbS9EWHhEOWpTSnFUYlkwQ2ptTUtWeFEwNWtvQVJLQndiQk84dUVwcGw2?=
 =?utf-8?B?VXEwaS91VlIxTlJuL0J2ZTBBZDRXZ2FySjBPSHp4THlBMy9RYW5GQUZVcjhQ?=
 =?utf-8?B?WWp1akNoZjVraTRmdUNwK3VaeHhpMlhWVkJwV2l3clhoWnQ4bU4yUURMSU1D?=
 =?utf-8?B?YWM0ajAzeExaeC9uOTFhaHNrcVZrQmZVU21EeDZMWEJpYTByQS9QMjBSWHJu?=
 =?utf-8?B?WFN3TDZLTnRkQ1V2Q1huNzNieVhSa2JiS2czMUFScFhoTFkxbGVmUHZVQURj?=
 =?utf-8?B?UUlMUDZicTB3eG1NeXVld0Y2TmxXZmMybzE2WkVDL3FyR0JaTUtlUlFsN255?=
 =?utf-8?B?RURqOG0yS011VzVibTFGMmMwdG1LY2VoSk0zZjFIcGNzUDdtNXo1dkFJclhV?=
 =?utf-8?B?UEtDeDFJRHZudFVacTdaOS9CNUFDZUVhRW4vUEpub2ZvNGVuUXBVVnIva1g4?=
 =?utf-8?B?TDVIWFNNa1ZEOVUyYWRNNVFIYnhJZnlRWHpObmd6cHdpL1pqb1FTaFZJd3BL?=
 =?utf-8?B?WW5WTkNDRDJBc3cxOUc3YVMwc1JFdktIaWJYK3lzMTFWUmdIWUdQZm9UQWg5?=
 =?utf-8?B?UTliLzBEcTIrUFNON1BMYjBKUFlXR1QzT2hOUTFOSXBvSCtCb2h0b2dJWkg2?=
 =?utf-8?B?cm9sUnlERnR2bCs4a0lGZVZsS2dYTHRJZ1BaWGMycXpjUjh1THY0dEhBTkI2?=
 =?utf-8?B?UGFOWXlpTHdyd0RCcVpCdGIxRUdsQXI4ZVpRUmJLalg1RlRETlhmanp4cTVI?=
 =?utf-8?B?K0NGTkw2Q0pEL01paExKNG41NEU2eTBaOGFCS2RaSXpIK3MrQi9QNTJUQ1Yr?=
 =?utf-8?B?dXpybFd6OG43Q0RZQU5jdk1yU2tQMnVzYVFTWHpzcS9JVVVicC9vTFQ1VkR5?=
 =?utf-8?B?TzZWaEVmbmxMZ0hGU1dEd2cxS3RqYVhVazlJWlZ3UUY4b3hmMDJYSjJ1Z2ty?=
 =?utf-8?B?Q3RTMTZ6aVhlZ2RObjZxb0FyMjA3cFRoMWN5dTAvSHpBVWpBRTM1VHpkcERn?=
 =?utf-8?B?WkRqZXFudlZ3bzdxTEFNOVFKVFlTSDFwMm1vRk52SE4wMkNkdXdVSjN5UmRx?=
 =?utf-8?B?d2p5N3NrblNNQklaVWxBTmdZMHdmVUVxMnhzYVIrWm9nSXIzTU9tUGsxcjU3?=
 =?utf-8?B?ZzV2ampVblRyQ05KSFZFUTBobFZ6a2FOMFZKTlJNcDllR2ZJZGt5MmltUTY2?=
 =?utf-8?B?Z3NBTXJVT0RGU3d3dWlubjAyNWRqTmQzOWhnY2xFanhtRjR5MzJVcENnSXZP?=
 =?utf-8?B?azhSUzBNYWhubnFyZXlBNmFzK1hORHVpRVhTNVJtV2kxaEFyZk05b0N1bWxZ?=
 =?utf-8?B?bTJVaHlHc2ZUYTE3MWszK0wxdHllOVB0WVZBWmlDWjRNVE8vbUxWY1A3dVJ5?=
 =?utf-8?B?c0ljNllleWZWem40TUxUSEZYNXNuZ2VuM2M4cnBTWXpZVk54MjJWRjc5SXhT?=
 =?utf-8?B?UDRkTlo1aEZIbThLV01BaXh2RWY4Q1F1Mk1aRExNWWRRc1ZueWNWQmFZRTFw?=
 =?utf-8?B?V2NyVlFyL01MQVVpa2Ivc1BncEhPU1BWTEtEeDVTTzhxTHFFSjQ3S05lZkov?=
 =?utf-8?B?VzdEcmwyODMxbGU1SHVvZStpa09LVDdiYkN1R2dsbXFQWld4TmJNeTVaa2pj?=
 =?utf-8?B?dnk4dXBiN21LQnc4ZStYL3lKT0FSVDRxRjlnRjVmalQzeDdlV3pzU2NmbjJk?=
 =?utf-8?B?UWhXdDN1b3kvRkdUOUVpLzRrcmVRd2JxL2NmL1VaZVAxblV0N2hadWkyQkli?=
 =?utf-8?B?aU1JWHkrWGZnNnVzKzZEQ1RCeTQ5alY0ZDl6dWlxek0va3Zpc1gvemlyTnp3?=
 =?utf-8?B?ZkYrTG5uZTBGaTNlTmJURVdZcW4xSVlDdGFrZmloUTBhWldPVGZOV1FoMjFr?=
 =?utf-8?B?VlNodUphanRWcDRmODVSV2UzcFRKM0tER1J1Y2haNU1PZ1lvc2xIdm1iVTVH?=
 =?utf-8?B?K2xHK3FXd2VtQytoelU4ZGxWNFFpT29RVk5MdmxqQ09hd29xZXM3OEV2QXU0?=
 =?utf-8?B?ZFVHVnZTdVI5Zm1ocjBJbU93KzdleC9CbkEraUowVGNmRUw5VnNsOStQaTB1?=
 =?utf-8?B?ZkFjSW44Uk92RXUxYko2MGVJbkRYRU5LMTVEaDJKWmVLeEVrK2pUUFNtT3Br?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e49082-8ed2-4ed3-391c-08dae724f098
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 09:38:26.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnZ8FVVrWIjd8g/v4bbIcBKasXgbUYXSUYI1ah5ZEvC0iC/1oWb3DLIsbFWqfsLce+CnC/B8BbJ1jeBeFyNd3dpA9/Zrou/DFYSMWQodljs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_06,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212260084
X-Proofpoint-GUID: NYShNzah0LYYQAJR3N6Y_lemEZd45NIg
X-Proofpoint-ORIG-GUID: NYShNzah0LYYQAJR3N6Y_lemEZd45NIg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> Thank you very much. It solved my problem; what bpf-gcc build can now
> be loaded by libbpf.

Glad it helped :)

> BTW, when I tried to use bpf-gcc in godbolt.org, I did not add any
> additional compile options, and it reported an error:
>
> /opt/compiler-explorer/bpf/gcc-trunk-20221225/bpf-unknown-none/lib/gcc/bp=
f-unknown-none/13.0.0/../../../../bpf-unknown-none/bin/ld:
> -pie not supported
> collect2: error: ld returned 1 exit status
> Compiler returned: 1

Hmm, I just tried and it didn't add -pie to the command line options.  I
think that somehow godbolt.org remembers and re-uses the settings used
by the last user.  At least when it comes to select the cross compiler.
Maybe it is the same with the compilation options...

>
> On Thu, Dec 22, 2022 at 2:26 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > So you need a bpf-unknown-none-gcc toolchain.
>> > You can either:
>> >
>> > a) Install a pre-compiled cross available in your distro.
>> >    Debian ships gcc-bpf, for example.  See
>> >    https://gcc.gnu.org/wiki/BPFBackEnd for a list.
>> >
>> > or,
>> >
>> > b) Build crossed versions of binutils and gcc, configuring with
>> >    --target=3Dbpf-unknown-none.
>> >
>> > or,
>> >
>> > c) Use crosstool-ng to build a GCC BPF cross.  We recently added suppo=
rt
>> >    for bpf-unknown-none there.
>>
>> Incidentally, thanks to Marc Poulhi=C3=A8s godbolt.org has now support f=
or
>> nightly builds of GCC BPF.
