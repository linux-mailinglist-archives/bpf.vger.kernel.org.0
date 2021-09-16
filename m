Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24D40D1D1
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 04:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhIPC6n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 22:58:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233847AbhIPC6l (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:58:41 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM43Tf015094;
        Wed, 15 Sep 2021 19:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=W6NhVxyuQKDwHFpeACAe0wOk3cFi1EHNhCpLwIGbF6Y=;
 b=OfAaYHsWif+8knfzDmGxGk1pvbhT/sMrh028X4UEMr381TTa1nqPKY0iMtmWzOmqKwV6
 EkSHiR39jHYpXLQGJn3ajuzuPbnExY0DNerYYZmY6fJxHMjGxXtcsTqjAW6ronR+OECg
 uGAULBzyJtHagWzdVJyI/ifmqXlkVj4H2BQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b398afger-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 19:57:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 19:57:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5wQ4N41blj2EfRkWB6mQUEVh2Jk1k4hCCIPxGdH8k41BVH1/PwWbsunn+X+xuKcjz5iFNgohnFW6ca+hnnWy1iFy9jGnLgw7S0kfT12z+DQgFQTMzaAdriYMedNP/vj7mpOrQaZXxQtSFfywkazEH2OBemMR5kRkJzTPRN4nXdKERgbR4ewR03SyYnExf/sPg4QtFUs6DLk/MaWHmAJSxtR4TnT8ANXpHjMdQg/OL9T7kT1e9UGdO/1VgaqOphn6t3rmFobrvuynlI3V2rGIJdExeH/XXHzmfjONNG1ulEAXKlvLTKGVKTciq+qNLbNbBr29zAndL/NUGyXlAH7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W6NhVxyuQKDwHFpeACAe0wOk3cFi1EHNhCpLwIGbF6Y=;
 b=WbYta2DBi7tDApaDSg9GToCQ5a9EA3wDyllaxQ5tbORWGXH9b4gk/44OHbqVTnZcLD5+pPEnt9SYIqdPGd+7RHz1B+TrNXA0cT6P/REBruY95gY/3bDPejoS7gPGvAsJT4xe4P8cyfIKEviOT6vQLa1eBco5VuE9bAYHocnSG1mIxdk/tnbDNqleeb7AYXfx5JIR/1MBMX6lbHytMdnOfx/bFf2psYSgnUBReD9Rt112AQWN7Rllbnp+NXMDjsKI5stWGMcBEu/qtMI08sDaAf1A+fveGRvVg4BD3Pz/ORlGvwU9Kdt1KEoGnGkMoelZWS96KZ9znqrb/u0f/8V+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4660.namprd15.prod.outlook.com (2603:10b6:806:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 02:57:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 02:57:07 +0000
Subject: Re: [PATCH bpf-next 2/7] selftests/bpf: stop using
 relaxed_core_relocs which has no effect
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210916015836.1248906-1-andrii@kernel.org>
 <20210916015836.1248906-3-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <973e1c40-b005-9b26-d469-fd3bcc8a8d33@fb.com>
Date:   Wed, 15 Sep 2021 19:57:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916015836.1248906-3-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:51c) by MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 02:57:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91647ee3-4234-48d3-309d-08d978bdabcc
X-MS-TrafficTypeDiagnostic: SA1PR15MB4660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB46603432F58587FA9DFB80FDD3DC9@SA1PR15MB4660.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBcXVXG5jJ/frImGmecMjKvL5mj8D4Wd9GlFLhiJFUPRSzImYUTmCD48CYUODAn8ZszBWakDEgoEnJTKDsvJHQr6VI14Jb1rvSJmsiUcrRIbSsge48X84XZSrjl9Y+9FUTTL0EG03jy8W7Lk0YJgb9LUJtsF4DoTzFh36Op0h6QZMKbbkMufO6aLDZ9eSnA5HgUgjz5A/UJtyTo9tO7QAkLn2IRPKAKLGPqv0o9eXKsDVms3L/rIECH01r9Bh9GX477AlRR4MMPfv3t3K3VrJOIK9sc4Q9yFw7eVzb+pFIbDjuRyAGQMR1qsiocItK3gh8FNhWaSxupQ0MiUN10hRhYpBYLajawuWt8/BSam40QfS33yTq0runSmmAnosi40CKr/RmDcdLEstvt4ygzEPj82PZ4A4unzFrskVcm07r8QML6M/UMius761WdayI1Hv1+9At/QZZwFVqcq/MQFOwinEZlY45HkB2vaHf8iRCcLBxN2Y56P2Yp4CTCxwSLupTZ7sFL+BUJZ5CPVn+hi7m2nughm1bSze3LcQ6Bq48RSNLG7r0J5FmtT3AAb1SS3bLMWbDgMXKS+CffIVtRRASunKQk06+fK93jMhGBN5bKSL0uVqrmr9W35aHEyjPBb5Byd2nq943RFbg59oYGPkWzXjQdgCOGSQ3rIrGxlZOrmfZoKR2xu8Vu/qpsFKO/YhQuw/RSycgZKv3BKSiP70vJc8T3tN8aSzbevs5q5qrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(66476007)(66946007)(66556008)(2906002)(558084003)(6486002)(8936002)(38100700002)(8676002)(2616005)(52116002)(186003)(36756003)(53546011)(316002)(31686004)(5660300002)(86362001)(478600001)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVB2bUs4Z2hJRFVvKzBmL0lHWDhaWkJLVExEdmtsMk92azBYQ3JtbXZOelda?=
 =?utf-8?B?UDBwTHhzV0xZWU16SjJ4UkVhR0ZCdjN1R1VObGlYU1BwNGZ4TUVVaFM4MTly?=
 =?utf-8?B?ekc3NUQ1WUU3alJTYy9YdkN6bkN0em9HejBFdWZ0UE1ERGpiOWhVMmtrblFj?=
 =?utf-8?B?WldlVEtRT3JLcHdiTml4KzZiVFJBekI3L0x5SnpBb2R0b0sxU29BMnd0aFE4?=
 =?utf-8?B?dmFnWUNrTTVzSFhFU3d1TS9QOUYwcWw4K3hnWEovLzBEZ2R2US9DN2VyWWE3?=
 =?utf-8?B?dVFQVnVYRVBKREdPSy8yeGpNMFZBNjNIQTNVenVUYlJZdU9heUthbUtPUmxp?=
 =?utf-8?B?cmlqLzJlVW5BcGVLODl4T3lMZ2cyUXNSRGExeFZnWUJuUFZZYTZ6Zkw2RXNr?=
 =?utf-8?B?ZU9wT09vbkF6UzFkazMzb05OWHp4Y1puRHdKK09qZ1lzcSs0aVdrRVZlK0hL?=
 =?utf-8?B?NkxsWU4vNm11bm00SE1GTi9WbzJPM2ZLOU5yMFBqZFE0L1NWd2pmbDZIcThq?=
 =?utf-8?B?ekF3bERVUEhaOXltTHBvdk4wakJUY0FhZ3FKNEFHVjlzR3dheTFvS09raTN3?=
 =?utf-8?B?bFJqOTBtV1ZRd0ZUbVZnM0tBQ1pQYmNtWE16a2V3ZGg5eWc0VTAwN0NsUjI4?=
 =?utf-8?B?L1Eva3lxQ01iQlViQUJnays4SXl4enAyVGlSeVZpWEFJb3haL3RtdFFMRkNw?=
 =?utf-8?B?enFCRVdrMnpSbnREVFM0cyt4cDhkMWdLMS9ld3VpSll4NWJQSDhVR2JNTkRr?=
 =?utf-8?B?RzNVZU0xdWluYTRvMjlEaVhyME9rYUpYTElLZi81a2tYVUJmSjE2NG4vVjJE?=
 =?utf-8?B?dlFnNng1NlNURVdScHppK2FadzEvRW5nZjgzc1ZoVlNWLzFXU2s4bU4ySERs?=
 =?utf-8?B?NUoyY1l1dVpQU09XQkNWK3Y2Tk54cTRHMEdtL1RsQjNtYjlhdStvdkhhdG9i?=
 =?utf-8?B?dkNPMDE5SFcrNDEvendNMzBqL3l2dTRnMnlnT2hRNGcrS2tKZWVScEJjK2x0?=
 =?utf-8?B?RlFqVnhsQ083bVRzcWRRMHRYM3R4MktPOFJBYjZwZHFEYmhGcWYxbzBaVUt6?=
 =?utf-8?B?N3hWakNUaThrcUVVS280VlhqUlRzcnpmUkFTSjlzRmlZemF0c0NlSDQ2aEsv?=
 =?utf-8?B?WkplVDEva2pINCtCRlc3S3R0aUVWTlhDd3dlYnUwUzB4akt6RjMzaGRkNGgx?=
 =?utf-8?B?cWhHNlFIWjQvSlN6cW9IMGJhSTJYR3plTHowUVBmTEZJckUrVUk4RGgvTlJU?=
 =?utf-8?B?eC9ycS83VVpKVnhXZTZ5VE85UW55TWxmVVMzZzliL1RpTWgvTHhLV3ExOHFo?=
 =?utf-8?B?RDlSZTl0Q3dJSjZZaE5qWjFVNlNTMmVROE4rMllZdmhEOHBhL0pJMDBvVUhL?=
 =?utf-8?B?cHEwS3htc01nQTdzRGFCNnlpcnJvbnVldldxUXpnWW1vam9DYTVwNDRtYkEv?=
 =?utf-8?B?TWt4dks3T2xNbngxZ1VpN2w2N1NxYjg2RjViUmJMOGh3cnIxY2tjeW9IV0VI?=
 =?utf-8?B?VFhUTkhSMlMrRy9DenB1OUhBSkhQM3JxU2hKOE9NVURUZmtWUTY1Nyt5eGly?=
 =?utf-8?B?TklXZHBpbFNuQVdNN0hKbDJpYnJmQzFJTzRUMG83M1JNUXRDZUVoVlRnaUcr?=
 =?utf-8?B?MlRkdVJNTnU4Qk02ZlRoTjg2dzFabmpUV0ZYczQyQVcvN2h5SEdmcEZzbnJo?=
 =?utf-8?B?M3JVVkdUSWxGRGd6T0dMY0tJWlNTWUxFTDRDcUxFMm42K1pZR09Fd2w4cDdB?=
 =?utf-8?B?RGMwUEJLQWJSQmUrQ3ppRTIzMVlwd3dWT2ZQUWVteFVLN29QQTk3ZU5DWVd6?=
 =?utf-8?B?ZnJKNzVRTmRZWTUyblZkUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91647ee3-4234-48d3-309d-08d978bdabcc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 02:57:07.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrP7g4YAwmeaTfGbFq7nqelhvf7SRCMkhu3hrwadXqnEmhivoelW7E3khExs5cws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4660
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: G7b-o1EtS78M8csyJGUti2AN4GH0VITE
X-Proofpoint-ORIG-GUID: G7b-o1EtS78M8csyJGUti2AN4GH0VITE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=856
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> relaxed_core_relocs option hasn't had any effect for a while now, stop
> specifying it. Next patch marks it as deprecated.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
