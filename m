Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5954634297
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiKVRhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 12:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiKVRhM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 12:37:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B726CDF2A
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 09:37:10 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMHYujE031292;
        Tue, 22 Nov 2022 17:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=G2ymM3GUq0K+TeU5a/umDbJgUGs4bqTNXgNKi1p9hvU=;
 b=qNcnT8CNoTxYqHjEMzlbXHGTVZr4u4uaXO28UsHNd0I3GYBjOwCMtvL+U8VvMu3jE9wn
 SlKmbiFgdVLIf03nKi2fEgTP88TCVPFltaa1YHQzi+7sAi5lxsHPuo6otxk/8PpkK8Qv
 R1JSOuNIaCt1fmBC+zpViaU01Y8DcNnzALAfdUy7T7rqPZMN4dCmaVOeiHu6iW12qX88
 hFXQmIgILE96Xp74DNahMaAraKpyqNJLx52axO1mVXjylLeTKSrVfJ08lK3J8PeoUbJY
 0kwvvxYVTDkQSxaHkyuNDi+kvXMF0B/CVnQhLiiDaAgbMBmAB8PWgArgbvOlX1WNl1j7 Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrd80put-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 17:36:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMGWFnY002243;
        Tue, 22 Nov 2022 17:36:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkcgh7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 17:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhmt8fIQLpYsZs2eq2HHD9DOTSG8M9OfoaWrEOZnqR0D9WXtQDVT/o3DkMmJkT4DgHd+0aGvnBvGU9A2/ifMsHK1QimYQe8BLWnkPVVs1HlDflRbi23MwlMpXevpjnS0mBInc5Q8AktnDCLfd3TtxFQVrfsWcrAKQH0xv9vU7t1IBZ+/Tic5UsuEweBWJmKU9wAtvs4dPKgbVMwkqFhggBKAGK+22W8Bgf4oSmKt+8bZopeZmNw9t3eRkVlyFo6fIWUdx6DKBCzE8O7V7Q6GWn/uCozLV7Ymj6inYkRKaBQPzYjUaelHaLbHa75tjOeGojdlNYh+PRFKKLY90wpz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2ymM3GUq0K+TeU5a/umDbJgUGs4bqTNXgNKi1p9hvU=;
 b=PdpD6/tXZS7g1U1aHW34Tf/AUm1lYvMshAuDl+02Zubh0ZrbrZLNIZqVVNvfVA2ZlP7TaHD7cBKEo/eQtbL478h5cV3Rt4bm7B21lTO5bUEYb3Gdit6iNB36UvOCDMp6cxQ8waJKvzo8g0NUp+ly/LL9TQw0raaqYW9w0VHESc/RiZ/33iGrhqe5XDaSA8LesUUUI+hU0+LRWnYNgGN8bQug8Pwtv+zaIm/XuTCcmGreChoocR0t3pAJKpz3TnbYjEImJijx9RG5XY2jRmlOebhMipfNau0FRscMGjm7dNmX7hQ6klzTmbKHY4wvockCdWujaMoEErUabvUqxrlmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2ymM3GUq0K+TeU5a/umDbJgUGs4bqTNXgNKi1p9hvU=;
 b=CLGbVlBFwoyPqyL9CR3ABAI6hbunzQNqv1kbZbcIoeIcu2BIzUbMX05hBeqk13lX4eZ396/YAMFot1h76ziCDV1huGH53tDfRFnWKIop3zduqk+NDYISuTkQ5aB1Qb9Ch0rXIYXcOqIuJ2VR2jThFsRRlxWsmKyEfmMc1NWkh3Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 17:36:38 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119%8]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 17:36:37 +0000
Subject: Re: [RFC bpf-next 1/2] bpf: support standalone BTF in modules
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
References: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
 <1667577487-9162-2-git-send-email-alan.maguire@oracle.com>
 <CAADnVQJ-WXrTj86Qd4PHMFo+fyyn+qWCLMVOHR+upj=fog7zNg@mail.gmail.com>
 <1b17769a-7e22-b8ce-afaf-70314cc31f4f@oracle.com>
 <CAEf4BzYoG9RSMdEFZKp8JG+cXBxJEygd0tAtOn-hvjoFFDWfTA@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <7fa26318-1912-c55e-2334-ed5d3b96973e@oracle.com>
Date:   Tue, 22 Nov 2022 17:36:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4BzYoG9RSMdEFZKp8JG+cXBxJEygd0tAtOn-hvjoFFDWfTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a01d26-a662-4002-2f0d-08daccb01a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8l30Dc8YPUK+TQ8cwqaFEiXWpHpCs8rf0uqsI9bXgqnxVabq8xn42QcznVIwHIMk/GNBFk+1HaLdpGodjFl8El92KCV9zCKKGkC+cwDphtJkG6ZeXMwyHmn+VDHDNKFWAFzP3+3wlCnZWb7Vb5/pl/9xCUBlr+ASbsZMGHRbESKEl019l4+4+r1v1jza6kJMVB/82PhE4LRYder1Xy9OERh05obMFXfXgez4c99wtm8F5BFEB5z1j/IY5GSIA63yL/Ps5/PqWmFi9DBf5RlTVguLODaJEQI+7A0hEZUcVOvTnpPlTSCISPO9wu545wn6fXhEccz9Y/DpxZLMTIjO0aVV/g1UA38VxrSsLT8AgyveBaSA3QWcDjjPBGGnnnI5XDCC8A/+7wSRZ3mJuRMDINGXTk2tdnbTi6XgioBVICbQR90RYQGNDDkdhwltWNmmGVvg4d/GB6TsUScsId3K0sNZmk4sZW/OEXi791oBYs3YVzNeDMaCbpa5E8ZY6QFNtBVONHEUz7Tp7Wa8JOzVBw4t0apulvdF3gt9AQjl41B4FokWTjADbh970Ix+pquiHrKu4doDRcSH+CfvqP0iFZ4PJgQgoJ3qYZdcyjpSrruTOviqCdwseAP/xeTjQBjaYwxvmvpIqnIAQUGuNJ3acbWK09VO0/imVnrhirPIRZx599rfnyPpBmoKFSXEr+/bIS2vMbHCG1yX/CfPFDWq6x97Wbnoo6IwAFnVLAOIDDV17k/l8PsfFFWr71vNXWgWZZmPby6dCnd/RfMWvIbmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(31686004)(66899015)(2906002)(36756003)(30864003)(5660300002)(44832011)(7416002)(8936002)(316002)(41300700001)(83380400001)(6916009)(54906003)(478600001)(6486002)(966005)(66476007)(8676002)(4326008)(66556008)(66946007)(186003)(2616005)(86362001)(31696002)(38100700002)(6666004)(53546011)(6506007)(6512007)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNPcmc3eUtmUkdGWW9ndWJRZmpkNUo0Zkc2ckFXaUUrakU5dUVqMUV6Uk9K?=
 =?utf-8?B?WURrTkpSZEc4UkhVT0szYVVLZzNpMWRQWEZpcy80R1dMcFdoamRFZHdJbkhW?=
 =?utf-8?B?MXIvaGRnR0xJWWxzQkhMZUtDbmtDWFJDOTR0RTljYXZ2cWpNcUFTU3AzZzVZ?=
 =?utf-8?B?ZU03dHVzOXIzQzlkdXFtcUhFaitqaVM5SUhYWkN2NW5JUDJaelVrOUVxampX?=
 =?utf-8?B?MDFRQnc4S0MwNWNzU3Znbkp0NnhKMmVkUGZMYXNYeTFlMlV5Y1RkSDROTnlT?=
 =?utf-8?B?VW84WDhqcVU4dzFFRVI4ZTJGZ0tFRERiczFtU2xybml6Z3lDZitRdFFyYitK?=
 =?utf-8?B?VnpLSnFPTHNrMGROMnlzK2V2MmJCVllQdlZ6RXRORE4xbStQbEpHT3M0WlJO?=
 =?utf-8?B?eVREKy90YWdFbUZqbGRSaklsSXFBamJqWkVmTmw0UjFMdjB2STJPSitrWkpS?=
 =?utf-8?B?N2diWjJrZlZvcEMxR1VVemMybmQ2eVozMkxrbWRRVnRIY1NMQUJWSVZpS1I1?=
 =?utf-8?B?T0QzY3I1YWZDeEJNMmVoQlhIVUhQWUFveHZDeGMyWDdVS29lR2tvY1BJandm?=
 =?utf-8?B?VmRwT3RBUUs0QXhQR3A1cGptSTgrZDF2cDExdUpIYUtDeGhRZVY1Qm1hemM5?=
 =?utf-8?B?RWR0c0o5Y1FUWHdQeVZ3bnhGaktLdStCV2VlUTFXck5NcjRuYlhGank2UnVy?=
 =?utf-8?B?Ym5oWjhHSkRhSTd4c1RwWkVuUnNCMm91NHZsYkpoRGlFZWNKMHVaWVVWU3Az?=
 =?utf-8?B?K1RPelpwNHNnZ2NVbmRrRkl5bS9LM0hZdWRIQUF4M3RNemdzcCtrOXdjUnhO?=
 =?utf-8?B?SDQxRWI5OGpQUXFqQ0RHVWdJMldjblM3Q2h3SGpNUWFJS0ZVVjdNQ2NGVm1Y?=
 =?utf-8?B?T2grcS85VzgrWnMwQjF3TkVnbEJCclBvUzkvMTVLaTB3RmtQYWRidmpFTFF4?=
 =?utf-8?B?MlpzcnNGMU1iUStyL3A5b2hUMmhIdzVBTDBxTDcrc0tNUHZGQjRoZ0MrM0Rm?=
 =?utf-8?B?bUdIU0dVdk1hR2RvQ3JNMUhhYlV5NWREM2M2Qis2SHl4NXN4b2U0Y0Q2aDB4?=
 =?utf-8?B?WG8zMUxid3YvUjUybE9HNEhlb21YNEdJMitEYkZjUnl5WXRabTIxdEJ0SG5X?=
 =?utf-8?B?Tk1qWDNwejBIcXB4d1ZjWVUxamY2dEJWL3JkSml2L2hvMW9yVkR6dkg5WFJV?=
 =?utf-8?B?bWFzN3UwV0NTVXNsbHVMQkpOS01IVFNDS2V4YnNPcC9xUy9aaFpBSm1haUIr?=
 =?utf-8?B?Q3dGYlJhbzcvZEhIVHhvWkhaWFVYUStpOElLeTlPejhlNlFid0l1NDNrL3Zq?=
 =?utf-8?B?b3VYSXpGZXNtUHJocDU1Q1VWWHBVUHlwVXYwSGx3ZkxmdTczTUVSSjVxSkZX?=
 =?utf-8?B?TFdqWnZ4VXBvaXZOYU4zdDZNRFZnMzM0bVNBTDI4alRNNGVYSFA5THFtMmlt?=
 =?utf-8?B?M2ZLM0RnOHovTzdzRm1tb3FWSWRRamVPa1Bta3RNdXp5bm1PVUtCbEdaUHgx?=
 =?utf-8?B?VlUyNzM3RnU2eHdacVRScUJ0SE5peXBmclJhZS9JaTBEbi9CdDlpNWRobDAy?=
 =?utf-8?B?MlZYendYSUZkZFREdjc4M09yLzNVQVhZM1BMb3E2WGVjVkdPeVltZ2krRzRz?=
 =?utf-8?B?azVxVmd2QnZRTUUvVHIyUHE4K2FZVW1ZajNnY3dhQXBIZFNLUlliQnVVYlh2?=
 =?utf-8?B?RkxsWXBvZFhNcklTTmtmYkp4aHk3WitJNWJmSm1kTEs4SWZBTjArSUN1YWsv?=
 =?utf-8?B?eDJpOWM5dWd6V1pPT0ZZTUMwKzhCV3R5bk85cWZNQ2ora3lxbDBCNkt4bGFt?=
 =?utf-8?B?WEp4bWZFRld5eUk3Q05vTVR5YVhxbi9PMEtkM3diU2V6V3ZzU1FxOXJDV1p0?=
 =?utf-8?B?TlRCM09rVlZ3MWFvMzhUT2djSFAxU0pva0s5Y2o5NUVQb1dyWU5DZHk1Q3RB?=
 =?utf-8?B?RWRhRHZPYWFzdjFkajgzc0EwTG5jMGZIcUlsclVFRG8xbFkzV05XZHZpQmFm?=
 =?utf-8?B?V08rcE52RFhyaGY0dFJRa3ZOQ2k4bFliYW1SbHVWanlGL2hyQVR2dlNuaWJY?=
 =?utf-8?B?dlVreXRwdmIwTjBISXR0YVQ2TFdROURRK0tETXdnRHlMWXo4OVZLcGFjempt?=
 =?utf-8?B?Zi9iNnF3ei93TFRVd2Q5MWxxdFNxazJRWlJYWGcwZkF2eDZmRC9OWWdEM0Zi?=
 =?utf-8?Q?siy2uobLaurazbODzJJTvdU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YXhMbzJzb0NGcFFUdG92ZDVGd0RaK0NXaFRaWlltdlFIU2ZKdFdjVnBaTkdD?=
 =?utf-8?B?NGcwRUFDQkhOZVNRbVRvenZFU2kyNmUyYlYzNkVTSmplWmFWS3ppbFhRSGpE?=
 =?utf-8?B?WWNCRy94RHRVZ0tKMGdwZ3hsUXBHMitOMHN5UUhlZ1duajExeUs4Zmh1ZlNk?=
 =?utf-8?B?T0tyUEUwSm51MmtGU080ajMvalpqQklHU0VPd3E4cUJJQndOTWN1T1c0U254?=
 =?utf-8?B?K05vc09CUVpLSEF2VElLN0lUbnpaZDN3ZUErMlJRalZDRyt0VjQ5SmRpNW1x?=
 =?utf-8?B?bW9HcjcvVUkyakdCR1BJYWJFNGhkQUx1b0pCc3ZhVVBUUDBSMCtUOUxmZDFs?=
 =?utf-8?B?MTlOWHphclpiTldIbXpyOHZ2VzVZK2pvVjZWQmxBTFptNnRJdDUydFl3cllH?=
 =?utf-8?B?VmE0cW9sWmNhMDVUZWlGR1llVnBPWllqcHpqMjRZT2pxdTl5U1RoS05TbVZ5?=
 =?utf-8?B?U0taNnlsVVZKOFVVeURBQUhQa3RReW1hdXZHclpXeHA0c1FnZ1l0VzMvM1FE?=
 =?utf-8?B?TWNlTFFJSEFjMU44NE1Gb1E5VHNkZStBK2ZnK1BGTHZGcDdVb1g3aUtVbEpS?=
 =?utf-8?B?WGdtRHFmSFVwaG52TmpQTXRTNEZRZVYwMGV3S2FvT3AzdjhxNFM0U3VhMkNk?=
 =?utf-8?B?YVF2YTI0Tmh2ZmlJWTI3djNmdXhQcnY4TFdVWk1QWmlJdk9GcEpCcXZzS3lC?=
 =?utf-8?B?UWdVQlhIUXJ5ZlhSY0g3d01PTmJvaW5EUFdnd3hXbVJzL3RjY0d0ejVKMExH?=
 =?utf-8?B?MzE5SlNWSGlCcXV4bW9qeXJCbjRNZk5TZ1lqWGRPYlJKbDc3MEFTMUNpMnBJ?=
 =?utf-8?B?WVUrT1hsTEtKcGx1SjJJT3VYYU8vamRMam93VkxXRDlDbHFTOXlKZnBKOEZ0?=
 =?utf-8?B?eWpjWU9NZ1BVM3ZkU2ZzcWVOR3RiMzBFMWhwaVpUYlRsc0FvVGxrclRpTmtW?=
 =?utf-8?B?QmJNMEVZSmlJYVovNFU1emtOeVZyT2IrL2RGU0dmWmxSTkRZUm0vMko2cHk4?=
 =?utf-8?B?MnZKZFRRbDZnaUpSV2g4aGhFb0ZoYUtHL25IWEJod1NqSTNhOWw5Q1JjOWI5?=
 =?utf-8?B?d2NNcjg0NDUwQllPL2hkSHZYRXora0pUcmlBMVZ3N1VwZ0hjRzFMYkVoQXJR?=
 =?utf-8?B?TUdoSG9vZ1hEQXRoZWlrN3IySXVQenJ2ZDZWUk9DcTN3RUxGd21vUWZXR2Ji?=
 =?utf-8?B?NTEwbFRpTjU5bGRnMFJQY0JzWDZ2cnZ6RndPdjJOVkVaZWtISnQxeWU5aExw?=
 =?utf-8?B?ZDhCY3RYSVB6SjV2T2dMRnhNU0tLdGdISHMxUzBMNGcxYkgwSUlncjlDb3U0?=
 =?utf-8?B?QTJyUUM4SlpaN1FMMVkxNEtFRVRYVEJEeGxmOE0vWGRISGRJWFQwVUxlS3Rn?=
 =?utf-8?B?bkpzMm9lMWcrMlp4M082dmxMS0N3dkVHc3ZSL3o4Yll2VDFUdlBFenhHVVB2?=
 =?utf-8?B?RVN0SGdpSFUxSktMTVZpeEp6UjJZSkNScXpBbVg4bW41d3Fqd1BzNnVsVzlw?=
 =?utf-8?B?akQ3Y1NYY3YzYkw1dlZUOWRIV1dEb3ViZURQNG9KVVptM0dxMEduZEJVcVRt?=
 =?utf-8?B?K3gvYTZSdWo0NzI3Q21sZ3UwbnpaRjZqaWZNcDYrVkFLSDZqODdROVRsaUhS?=
 =?utf-8?B?M2JZODlVOXZUTnlGZUpZbVFHZ2hsTFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a01d26-a662-4002-2f0d-08daccb01a9e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 17:36:37.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG4kmm/sYjIcqYxhhw2RwN9krBVJnyJRmZ8PYb97kpJHBWoUcE7O1N57NFhAReHHHN1/MZkQEpBys3nMRbI2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220135
X-Proofpoint-GUID: eYM-GyhhCOxeOqME4rqiItyS1KUU3ffD
X-Proofpoint-ORIG-GUID: eYM-GyhhCOxeOqME4rqiItyS1KUU3ffD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/11/2022 22:43, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 8:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 05/11/2022 22:54, Alexei Starovoitov wrote:
>>> On Fri, Nov 4, 2022 at 8:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> Not all kernel modules can be built in-tree when the core
>>>> kernel is built. This presents a problem for split BTF, because
>>>> split module BTF refers to type ids in the base kernel BTF, and
>>>> if that base kernel BTF changes (even in minor ways) those
>>>> references become invalid.  Such modules then cannot take
>>>> advantage of BTF (or at least they only can until the kernel
>>>> changes enough to invalidate their vmlinux type id references).
>>>> This problem has been discussed before, and the initial approach
>>>> was to allow BTF mismatch but fail to load BTF.  See [1]
>>>> for more discussion.
>>>>
>>>> Generating standalone BTF for modules helps solve this problem
>>>> because the BTF generated is self-referential only.  However,
>>>> tooling is geared towards split BTF - for example bpftool assumes
>>>> a module's BTF is defined relative to vmlinux BTF.  To handle
>>>> this, dynamic remapping of standalone BTF is done on module
>>>> load to make it appear like split BTF - type ids and string
>>>> offsets are remapped such that they appear as they would in
>>>> split BTF.  It just so happens that the BTF is self-referential.
>>>> With this approach, existing tooling works with standalone
>>>> module BTF from /sys/kernel/btf in the same way as before;
>>>> no knowledge of split versus standalone BTF is required.
>>>>
>>>> Currently, the approach taken is to assume that the BTF
>>>> associated with a module is split BTF.  If however the
>>>> checking of types fails, we fall back to interpreting it as
>>>> standalone BTF and carrying out remapping.  As discussed in [1]
>>>> there are some heuristics we could use to identify standalone
>>>> versus split module BTF, but for now the simplistic fallback
>>>> method is used.
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>
>>>> [1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/
>>>> ---
>>>>  kernel/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 132 insertions(+)
>>>>
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> index 5579ff3..5efdcaf 100644
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>> @@ -5315,11 +5315,120 @@ struct btf *btf_parse_vmlinux(void)
>>>>
>>>>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>>>
>>>> +static u32 btf_name_off_renumber(struct btf *btf, u32 name_off)
>>>> +{
>>>> +       return name_off + btf->start_str_off;
>>>> +}
>>>> +
>>>> +static u32 btf_id_renumber(struct btf *btf, u32 id)
>>>> +{
>>>> +       /* no need to renumber void */
>>>> +       if (id == 0)
>>>> +               return id;
>>>> +       return id + btf->start_id - 1;
>>>> +}
>>>> +
>>>> +/* Renumber standalone BTF to appear as split BTF; name offsets must
>>>> + * be relative to btf->start_str_offset and ids relative to btf->start_id.
>>>> + * When user sees BTF it will appear as normal module split BTF, the only
>>>> + * difference being it is fully self-referential and does not refer back
>>>> + * to vmlinux BTF (aside from 0 "void" references).
>>>> + */
>>>> +static void btf_type_renumber(struct btf_verifier_env *env, struct btf_type *t)
>>>> +{
>>>> +       struct btf_var_secinfo *secinfo;
>>>> +       struct btf *btf = env->btf;
>>>> +       struct btf_member *member;
>>>> +       struct btf_param *param;
>>>> +       struct btf_array *array;
>>>> +       struct btf_enum64 *e64;
>>>> +       struct btf_enum *e;
>>>> +       int i;
>>>> +
>>>> +       t->name_off = btf_name_off_renumber(btf, t->name_off);
>>>> +
>>>> +       switch (BTF_INFO_KIND(t->info)) {
>>>> +       case BTF_KIND_INT:
>>>> +       case BTF_KIND_FLOAT:
>>>> +       case BTF_KIND_TYPE_TAG:
>>>> +               /* nothing to renumber here, no type references */
>>>> +               break;
>>>> +       case BTF_KIND_PTR:
>>>> +       case BTF_KIND_FWD:
>>>> +       case BTF_KIND_TYPEDEF:
>>>> +       case BTF_KIND_VOLATILE:
>>>> +       case BTF_KIND_CONST:
>>>> +       case BTF_KIND_RESTRICT:
>>>> +       case BTF_KIND_FUNC:
>>>> +       case BTF_KIND_VAR:
>>>> +       case BTF_KIND_DECL_TAG:
>>>> +               /* renumber the referenced type */
>>>> +               t->type = btf_id_renumber(btf, t->type);
>>>> +               break;
>>>> +       case BTF_KIND_ARRAY:
>>>> +               array = btf_array(t);
>>>> +               array->type = btf_id_renumber(btf, array->type);
>>>> +               array->index_type = btf_id_renumber(btf, array->index_type);
>>>> +               break;
>>>> +       case BTF_KIND_STRUCT:
>>>> +       case BTF_KIND_UNION:
>>>> +               member = (struct btf_member *)(t + 1);
>>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>>>> +                       member->type = btf_id_renumber(btf, member->type);
>>>> +                       member->name_off = btf_name_off_renumber(btf, member->name_off);
>>>> +                       member++;
>>>> +               }
>>>> +               break;
>>>> +       case BTF_KIND_FUNC_PROTO:
>>>> +               param = (struct btf_param *)(t + 1);
>>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>>>> +                       param->type = btf_id_renumber(btf, param->type);
>>>> +                       param->name_off = btf_name_off_renumber(btf, param->name_off);
>>>> +                       param++;
>>>> +               }
>>>> +               break;
>>>> +       case BTF_KIND_DATASEC:
>>>> +               secinfo = (struct btf_var_secinfo *)(t + 1);
>>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>>>> +                       secinfo->type = btf_id_renumber(btf, secinfo->type);
>>>> +                       secinfo++;
>>>> +               }
>>>> +               break;
>>>> +       case BTF_KIND_ENUM:
>>>> +               e = (struct btf_enum *)(t + 1);
>>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>>>> +                       e->name_off = btf_name_off_renumber(btf, e->name_off);
>>>> +                       e++;
>>>> +               }
>>>> +               break;
>>>> +       case BTF_KIND_ENUM64:
>>>> +               e64 = (struct btf_enum64 *)(t + 1);
>>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>>>> +                       e64->name_off = btf_name_off_renumber(btf, e64->name_off);
>>>> +                       e64++;
>>>> +               }
>>>> +               break;
>>>> +       }
>>>> +}
>>>> +
>>>> +static void btf_renumber(struct btf_verifier_env *env, struct btf *base_btf)
>>>> +{
>>>> +       struct btf *btf = env->btf;
>>>> +       int i;
>>>> +
>>>> +       btf->start_id = base_btf->nr_types;
>>>> +       btf->start_str_off = base_btf->hdr.str_len;
>>>> +
>>>> +       for (i = 0; i < btf->nr_types; i++)
>>>> +               btf_type_renumber(env, btf->types[i]);
>>>> +}
>>>> +
>>>>  static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
>>>>  {
>>>>         struct btf_verifier_env *env = NULL;
>>>>         struct bpf_verifier_log *log;
>>>>         struct btf *btf = NULL, *base_btf;
>>>> +       bool standalone = false;
>>>>         int err;
>>>>
>>>>         base_btf = bpf_get_btf_vmlinux();
>>>> @@ -5367,9 +5476,32 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
>>>>                 goto errout;
>>>>
>>>>         err = btf_check_all_metas(env);
>>>> +       if (err) {
>>>> +               /* BTF may be standalone; in that case meta checks will
>>>> +                * fail and we fall back to standalone BTF processing.
>>>> +                * Later on, once we have checked all metas, we will
>>>> +                * retain start id from  base BTF so it will look like
>>>> +                * split BTF (but is self-contained); renumbering is done
>>>> +                * also to give the split BTF-like appearance and not
>>>> +                * confuse pahole which assumes split BTF for modules.
>>>> +                */
>>>> +               btf->base_btf = NULL;
>>>> +               if (btf->types)
>>>> +                       kvfree(btf->types);
>>>> +               btf->types = NULL;
>>>> +               btf->types_size = 0;
>>>> +               btf->start_id = 0;
>>>> +               btf->nr_types = 0;
>>>> +               btf->start_str_off = 0;
>>>> +               standalone = true;
>>>> +               err = btf_check_all_metas(env);
>>>> +       }
>>>
>>> Interesting idea!
>>> Instead of failing the first time, how about we make
>>> such standalone module BTFs explicit?
>>> Some flag or special type?
>>> Then the kernel just checks that and renumbers right away.
>>>
>>
>> I was thinking that might be one way to do it, perhaps even
>> a .BTF_standalone section name or somesuch as a signal we
>> are dealing with standalone BTF. However I _think_
>> we can actually determine the module BTF is standalone
>> without needing to change anything in the toolchain (I
>> think adding flags would require that).
> 
> Why not just extend btf_header to contains extra information where we
> can record whether it is stand-alone or split, what's the checksum of
> base BTF, etc, etc. Yes, we'll need to teach libbpf and some tools
> about this v2 of btf_header, but it's also an opportunity to make BTF
> a bit more self-describing. E.g., right now there is a pretty big
> problem that when we add new BTF_KIND_XXX, no existing tooling will be
> able to do anything with BTF that contains that new kind, even if that
> kind is completely optional and uninteresting for most tools (e.g., if
> some particular tool didn't care about DECL_TAG). So with v2 we can
> record a small table that records each kind's size: extra info size
> and per-element size (for types that have vlen>0).
> 
> More upfront work, but solves few existing problems and we can reserve
> space for future fields as well.
> 
> WDYT?
>

Sorry Andrii, missed this reply. With respect to self-describing BTF,
I've got a patch series that I was planning on sending out soon which 
approaches this by describing BTF kind encodings in BTF. The handy thing
about that is as you say it allows us to parse BTF even if we don't
actually use features, so when new kinds are added we can skip past
them, but if a new libbpf comes along we can potentially unlock these
features. This is particularly valuable for kernel/module BTF since
the kernel might be around for a while and we would rather encode
BTF optimistically. The other useful thing is it won't itself require
any BTF format changes; it's simply a matter of adding a libbpf call
to pahole which says "encode BTF kinds", and that part is done using
basic BTF kinds like typedefs+structs. The benefit of doing this in 
BTF is that we don't need to worry about header incompatibility etc. 
Just adds a few hundred bytes to overall kernel BTF too, since kind 
encodings are only needed for vmlinux (or standalone) BTF. We also
end up with BTF kind structures in vmlinux.h, which could potentially
simplify BTF introspection in BPF programs in the future also.

The handy thing about this approach is also that the kernel code
that parses the BTF kind descriptions is easy to backport, so we
could even look at backporting that patch to stable kernels such
that they would be an a position to parse newer BTF kinds even
if they could not use them. Because that parsing is based around 
interpreting existing BTF kinds, it is minimally invasive.

I'll send it out as an RFC shortly to provide additional context.

Alan
