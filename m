Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF42653643
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 19:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiLUS0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 13:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiLUS0M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 13:26:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E5426A8C
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 10:26:11 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLHDlTE012259;
        Wed, 21 Dec 2022 18:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L1cCC3QB7oaACRh0pZqnRZs2H22nY1OmVJRHwDM4jkg=;
 b=R4r52+8Mcgew9M+Zk7Eagt1ib3dC5guql1lu5OpkQh7pVWhjTJrZyC9wPw+NJgCfHn2b
 T6TNMbFB08KgombsKQ56zDj+bQNw71NZOqyBdSVMqUySHWaoc+QkHFTjQwUvgQqZ+KYS
 IjC1RKZWeyOe89GqX4Lgl9bqUGUBc2y/I9RLHeQZpi5aqS1No49fG+UtNF2fjgAyTcqI
 zyrgu/zGo1udE6B0fbQqtklmKSW4WU64sr/a7qBZDvr2QZFVibC9rtCtHIodcJpzsphj
 MoXXG4LWCjwhCz95tenrJp+jL9trFs2PUVeGPFqYPczFUIphyMPmbUWGVa9rXphifMl5 NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tm9hub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:26:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLHUHoW003403;
        Wed, 21 Dec 2022 18:26:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh4770209-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:26:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+nwBi5Yw82+Ax9j5Mkrt0b5T1rFtvB2QSiyWEuMb4deUst0L6wIpoF1+YDbQs+98q/tBsNPER3mpHmxHjw5mGiJUGjU/0k/uWKY8EW8TdD6IPomUoH9R+9t1Bv+2sr6zzvLt5cDjEmQ6+kkxUaRs7uk8vPGTB+irZeCJAM/96xbz7L2MUh5ChHG46qxEGrh0D2BzzUvQ/In7CU4BF02nvM5KWC9TIbKoRIRgknhf50qLPqbvdxpKbVsqEJXV8IAwhKMEOFK5KAdwMhnNXwQIJrJCKPF9s0IcIM6hFO+7RRwLzMDLqMh3S+w8cSizXB3w1KomYLGyJqjPtEi0G7KFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1cCC3QB7oaACRh0pZqnRZs2H22nY1OmVJRHwDM4jkg=;
 b=AMUvV3THUobGAKInsZZl6DfEwkoz7AR6Sm1+r+GFWzVNSV7wrgzosz2Jn1ApkKOYPqVbpSgOh8acKcpt+LNDdAer7/1IN5ErIz5WE8Vr27W7ZWy5KXipoeJklbZBcwXkUtlRCg9bCpNzzvwZ+mfI+yFHHaHmiDU6ggLKoR3KOAzGOwUScyg2FmVm44OAv170gW9P58wpCLymn2+EKEB0tu2FfJ5BGiF2Ij7HwlJaP00Yoymm1zziIMxXpSrDxaXBOX2Xhbc8iJnMtvHpXRhrVsUILU9oDT/G3N4dRisH8znZyy/Kf5MhmMApI5wgRjM3TlhF0n8g0dpkgkHL43Rnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1cCC3QB7oaACRh0pZqnRZs2H22nY1OmVJRHwDM4jkg=;
 b=oZDI9ificBHqRTYfpPerKUQ8KVH0c1/gteuoU0nhkEYAsPg+x25E2kouw4aarG/hjy25A4pkzGhBMQPLRPaLMOqCxgQQ3kfbDR3ezyiZmpqqUuqse6fQ+v/g4r/6x0YfQuA6Bldjq6NNlAqimm1yUPF+WAGU53gzZegMdsbjYHg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH7PR10MB5772.namprd10.prod.outlook.com (2603:10b6:510:130::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 18:26:07 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 18:26:07 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     SuHsueyu <anolasc13@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Support for gcc
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
        <871qosy5u8.fsf@oracle.com>
Date:   Wed, 21 Dec 2022 19:30:13 +0100
In-Reply-To: <871qosy5u8.fsf@oracle.com> (Jose E. Marchesi's message of "Wed,
        21 Dec 2022 19:22:39 +0100")
Message-ID: <87mt7gwqx6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH7PR10MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d78cc3-9dc7-4943-4f5f-08dae380d370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W14yMb9kZgG4JmM4yqr0QXzX2ereFV4ePB5c1uUWn2wzYD20ubzVFXhPKvhKWFs0He+arqHyC1fgULJdSbIdZUw04QZUy9mCZd/VTh8G/E8iCQHcRvsij1oVWDWs7KCEZaxMrt3FMFEDZZigaeSwLY+o2tPL42ptRSwerwQYyZMvMpUIrn91MFzwayZGH/UJWu999ydGqJf/NS5O+8Fy6wFU1fOC9v/dH594/N+O0v4RLwVy9x0ff2fQKcte3v8icinR2qZQOUMer3xsPqx0IkvpFu0BnSuhEr0UpQ0AAg0CUHRYNVa+egp5iyc/5t40DgnYFWIHe07WT+1rjnKRkdNDDkW5OVhgnKwYqTmyQH57zzenpzvjxlpj1kXjeTD8SL6rC64X4tGYsDLHXlogFEyI5ig8D5mJg8RbKPGEdthTuMYlimEjABpXZVe3JPWvT0Sjq3qeREsiR0jw0Iz63rO0IBwxioOW3qjEmdC0j2zAjfnl5g58P6pWlwA5vuVgHUBzPfowi65kKo8KXCje9r73Jzt1FqmhTdRuA8kuiaJ9lLdSo7fUjsL6UdH03L8K34Ax7/u8IAteYrg7kaIi3K7XiPU0XzCyv4lXUQgW6ZMR/xFLVbp5e0ZGtxo13X0L80YGP5qWCKAP5F7/SZfUlbU5O24tEEkGyHOaWYieZro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(2616005)(38100700002)(6666004)(83380400001)(186003)(3480700007)(26005)(6506007)(966005)(6486002)(478600001)(36756003)(6512007)(4326008)(7116003)(8676002)(5660300002)(66476007)(41300700001)(86362001)(66556008)(2906002)(8936002)(316002)(6916009)(4744005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3Z5d2x3VnBFUGM2UktxdmZ3TW4zWXN3cXpDOU5mcllSb29xaEY3dkl1dVY0?=
 =?utf-8?B?V0laUi9kOGpYcDEydmxUZXFNZDNQd3VWSnZlOWM2UXdCbGRsY200ZWM2cE9R?=
 =?utf-8?B?cFZFYldKWGZ2emJIMXJzaVpKQ2pBZ2gvVndiK1JpUkl5V2lHT0d5QUd1NXhT?=
 =?utf-8?B?QlBNZm95Wm9GUkw3aWRMS1dWZWoxRWdMaDdqMHFpS1ZCNGNyVzFTdnhjRFM4?=
 =?utf-8?B?WEl3bXVFM3hFZFFKT1dXY2VMS2plZHgxYUxkYi9RUS9SQnB6S1lEWnN2ZGMy?=
 =?utf-8?B?TnZqNU9NZWhHTU1DTGZQSWE5K1l0SjhGNW9iOTlaajdTd2VsNUNPTVlMMFh2?=
 =?utf-8?B?YUdYbXpyaHJacDNVbDh3U1ZvSFhuOU1kMjBKck1CeWxHSWxOdnc2NktVc00y?=
 =?utf-8?B?eGYrK0thTFJWcmZZZmVUQTltblhYT1VGWEI2ZWthSzZIMDNtNEFySHU3YXZR?=
 =?utf-8?B?TGN5VXYyRnI4Qi9rSjh0NVNoenRweWxiUDRQUlRVMUkyeERtcWtXeDduOE02?=
 =?utf-8?B?WmNQWldjQzhDZnpMazRhQ3g3Y1BvcXhZWm5FM3lrWDkvMHZrNCtaVEIwWjhN?=
 =?utf-8?B?SFY1alFZY1p3bzVoTFVhWUR1R2FWSzVmOWJ0SHpyQ2MybEk5R0hhaUVjTzFq?=
 =?utf-8?B?cnV0OTlqMFpTYmgrNXhuVHVDakhPdSsyRFlIeE9acnBXNk5ZdGdNOHdKOXRm?=
 =?utf-8?B?MXJvSmZyWDMxOEsxOWh0UW1HNHpoSFl6enFqRVgyUEZvZVZpWG1GcjFHN1pt?=
 =?utf-8?B?R3Z5bHdQWWZyVjR6aitFUTB5TTRBblUxWFY3NUZOdWs4ZFBWTTB6bFhheHZX?=
 =?utf-8?B?QmEwblp1RFhlL3pYMENTaUtIZXozU0hBMnpjeFloOFVObFNXSVU4TS9oSW9F?=
 =?utf-8?B?SjR0SVBiN2ZSRTNVeEFST1ZqUWlXdm5PdTdsdFVGa29kK0tDc0ZmM3p6bEl4?=
 =?utf-8?B?cmgzR1k0VDJZay9rdXV5Z20rWDV4ZWZTaUJuZUdOcWFtN3lDaC9iMFVrUzlW?=
 =?utf-8?B?U3JMYjJIVGpkaGl3U1pQSkllazhUaEFVbWxDRktmR2M1a25rVTh3MzZHamp4?=
 =?utf-8?B?VXh3SXIxdFRDd3o4cHkvS3BlQkpDaEg5dTd3bTcxYXNFSEFZbVdQWkJvYVJ6?=
 =?utf-8?B?QmRHR0VmRkprSWlNZ3JYNGNuZk4ySG55dUhvRXAyc1NYbW9nWDhXblJzT3ha?=
 =?utf-8?B?eXh4WlJqSktkTnF5ZzFEanpReVIremxYT3Rwemdlb29pWG9IQnh3VmVCSFZk?=
 =?utf-8?B?M0F3VE5oaVBnQmJhZ2ZrdTNxRTFLcmxqc3ErOVNjbWlCT2VyNHpDalVqL01X?=
 =?utf-8?B?V3BXTm1SNjltTktqL0dnajg4d0ZyUjdYTVFHZ3ExUVRmZDdUSkt6cVY2WGVa?=
 =?utf-8?B?aWQzaDYyeWkvblAvTHR1VkxTV3Z5L2RyN1lSV05CNmcxY1h6RnV1OGJhU01r?=
 =?utf-8?B?bHlPT1B1a3lHMXdzQVhhNFpqNmdrT0ZnRTFTVjJrc2ljWTVtWWt5TE1iMW5K?=
 =?utf-8?B?Zk9zN3Q5dE9zdk5DenRIZGxKNTR0Rlg2bWhLWnVtK1hNUnB0Z29ES01PYUVJ?=
 =?utf-8?B?cjd4UnBBQ0QrQVRCYmJQR2Rabis5Q0NDdFREZXg0SGFKLzU5UGN1aElzOFdB?=
 =?utf-8?B?N20va2RJb0pSVUhGYk0wWHBlQ2R1cW5FeGpGdG5wTVdqbkxRNklRSzBienBo?=
 =?utf-8?B?UmNiblRZVi9CdlQxejNmSkROMTR4c3FiMXVQR1VHR0VwZlo3ZXppdnA2L2Jo?=
 =?utf-8?B?SUlqdlJqMnlzODdHSDBJdHpEeDgyL1hyUmdGYkZOUjZvZVowWVFQVFhEcDRB?=
 =?utf-8?B?bm45dTFpR0t6YmFvVlN4TEVvQ21WRW5jU1IxMFNDU2RqN0I4ZlNTcnVBcFpO?=
 =?utf-8?B?K0l2YUxYUlRkaCt3MkdhOUpUR2ZjT3o3RlNSMDJpUEF2KzUxMU1adStSMWFk?=
 =?utf-8?B?ZGhOc3Bsd0MrUTNBQytFTmZ0WDMzcVF1K0d6bHlDYlhFSGo5N2x5WXZuaXht?=
 =?utf-8?B?V1RlNlZsbHNNUGg3Lzk2TzRqdWRJRUs4V1RGeFN3cEFBaGdyUXhpdy94TVRM?=
 =?utf-8?B?bGc3OC9VeWFHRzBoZUV0SGh4MU0vd1lkMEpvRzBLTnZGQVZpNklIL1NrT0Rp?=
 =?utf-8?B?MHRITUpKemRHa092TjlEMHMyMU1rSElrK0NSZlp4L21kYS9IUjZheVduN3Bz?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d78cc3-9dc7-4943-4f5f-08dae380d370
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 18:26:06.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Heg2npBGxHJ6U52I4iMLKMQM19bJ4j4l/WQ8jpT9IJ6bWDryZN3bbo0AAZmv5P5HXRNPw2qLDSiKqXTMsIjNAYc4qN1/biNSDjahQMhVSUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_10,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210155
X-Proofpoint-GUID: eIFgKqEgxVfkQI7IGM4PNrNqbFU6s_aL
X-Proofpoint-ORIG-GUID: eIFgKqEgxVfkQI7IGM4PNrNqbFU6s_aL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> So you need a bpf-unknown-none-gcc toolchain.
> You can either:
>
> a) Install a pre-compiled cross available in your distro.
>    Debian ships gcc-bpf, for example.  See
>    https://gcc.gnu.org/wiki/BPFBackEnd for a list.
>
> or,
>
> b) Build crossed versions of binutils and gcc, configuring with
>    --target=3Dbpf-unknown-none.
>
> or,
>
> c) Use crosstool-ng to build a GCC BPF cross.  We recently added support
>    for bpf-unknown-none there.

Incidentally, thanks to Marc Poulhi=C3=A8s godbolt.org has now support for
nightly builds of GCC BPF.
