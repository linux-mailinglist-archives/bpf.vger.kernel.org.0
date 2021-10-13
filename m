Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555C342B0DE
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhJMAOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 20:14:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233546AbhJMAOG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 20:14:06 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CMfsfZ019063;
        Tue, 12 Oct 2021 17:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zL+kdm4WJdMrfLKPDMjdjmHbt2vKffkp0hY7g37TkzU=;
 b=LzpacyJKV4BeVJn+lZYHIHJrjN0FKtahc6iTYp6EKnmYPHwdC+OUI8649ulH8Cv/CVhp
 ti29pO/wsLZxopILzLYEMCFtvhiCM3FQJ9ofa8MTQoTd0ZS5q+iPVFX/ssy0ljrIn/c4
 XlRbdO7yga+RXNCv8uqF5qzmoPzC4NiMTi0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bnkcpggp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Oct 2021 17:12:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 12 Oct 2021 17:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFO++LBdfL6Eo8fhB4LlgRV5TJHFENaVBVuPwwJiFPfz5ZkilniSaeHQ3u1MKs8DjKEfljUaklwAwND8x2DggY5u+bBgex6R1Qw8rxYvd+SUITixkHqASuu00qtWg7asQj9OJthegaTAPqw7RaZ3xtJ+L2JIKrtIh9hMHCnnW5OSAz8wBcg2I8gjbQaBRBoFwmABdtEYr8qYhv259eYJG8eetdqWtVscfgV+LNks81jpOog024rcs4LShmvpsKEFLBUORZUCGnI0j8ChaUbHOgDv1GXKDD7UuQtITkRfhhdCcgmIDxxUetrANEDp6nrOfab/QqQ3ua6WojPg3TPy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL+kdm4WJdMrfLKPDMjdjmHbt2vKffkp0hY7g37TkzU=;
 b=JKN1j3ee5/ot4AhmIPUE28s+GgdEX19Q/f+wDVsT3d10gsXFOh6vJLY0ygengsmNUOoXzxdYJD8gtjxmTWyozor3QtuKepnilG/hMnVh14UQs35iTt9n1TYEX1M+5P6U3dAazjisX5TRfUBpCZKFIyLbK1elo3fmp6Pbiofswxqbwv2VYh+MqmFTELsrAUG8r22EIyGgLgmJ952ncibXA9qnSlnNLoFc6lIMA0YQMjbNRN2Q//FirkWrktMh6IoUtxMhSO54ZLXhSrW6Y0V7t7kL8GFEa25pgmeINzXaYcdgn4Ed+lRSu/zTF3RhjWMwvO6vlP3BLHc/LTmCa0iiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR15MB2510.namprd15.prod.outlook.com (2603:10b6:805:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 00:11:57 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 00:11:57 +0000
Date:   Tue, 12 Oct 2021 17:11:52 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
Message-ID: <20211013001152.6f4ssugsebosrjh7@kafai-mbp>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com>
 <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com>
 <87o87zji2a.fsf@toke.dk>
 <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk>
 <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
 <877deiif3q.fsf@toke.dk>
 <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c091:480::1:d62d) by BL1PR13CA0375.namprd13.prod.outlook.com (2603:10b6:208:2c0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.5 via Frontend Transport; Wed, 13 Oct 2021 00:11:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617d311d-487d-4878-37f8-08d98dde11bf
X-MS-TrafficTypeDiagnostic: SN6PR15MB2510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB25106F7EDACF4E6BCC8B8493D5B79@SN6PR15MB2510.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApLXwRYsRIMGD9ZCKYFWaiumjCZDQaRdrbwPauM1BeadFmNr/F42GyLMYXpm0VlRI+EtGi5Zs1cWVFBGDRcRdWcOIg1okZ1bYtH02puvssfrEQY1AVvoO32gNln9JqU5cKpdIH/bHs3kBWInMfEUBlrEpikUPdsLShlthbLxa7Ojs4ys0FW4kO8tzAeVZju3DV9iLiar0IPjeob7R95+iONK8xDbrYj8vvvtK20oYgc34wz96RL+QE1/P65rpDbyXM1YqqEMn0D/UPZnGzNDx2MhnQ2b8Kzt3TialbrIL9R8Kkc8Nl7FvyX1nDL/xVNE/sqrld1oGn6+OzqVcZbA3KnGQbqpfyNMn3UX0leV+43IH5uBNXWwvAENV8cfutD+Y5CmCzD1mGUc9DOBuTAQToSBJClYt53z7fubCXQWsng+y/7bcUY8oXAoV+JcGcXa+PCMYt01GhP6vgDsMxuHm8y+iAf9z++oBKJ3qldcbk7n2gaKFeQF7fnF1rAxStKsrcOsmhEPpIWBm16fIFeHD/MxOOhEJXeIkBP6YmioiSkcgPMCbpIIkSWfSykiieoYkjFgb/XpLwb3iiLjOPFfHL5wmocJADl2xB/Adz6K1njDXExmqNM4s5RabA9RVKmAsxdeJ3YXAp6zrVrmr3Yeww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(8936002)(66946007)(2906002)(66556008)(83380400001)(6862004)(4744005)(66476007)(8676002)(186003)(1076003)(316002)(508600001)(5660300002)(6496006)(33716001)(38100700002)(54906003)(9686003)(86362001)(6636002)(4326008)(52116002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X8qAkcA4dV79DVwlVTuPnIjEehL3p+pF0ql787wlVzBZlHloPjPLJ38xABvD?=
 =?us-ascii?Q?UBoTjDji2gYKiYz0h2rDxai5pVsvDhva5SxOwuLnIwK00xKiqduhZgRvWSgW?=
 =?us-ascii?Q?bv5Lb7/wxZL1idbB3k19jb0q6kEN1sa6hHa1GcInmoAuQXfFFK+lI59aRKnw?=
 =?us-ascii?Q?yu0ZGXtjVfo0qTeaVbc2l8ordq9Cui9p2vGg3oVgZiwyaiOQOgbDTmMhno91?=
 =?us-ascii?Q?GpggDJCfllS1BESrkL1z+SVAwxwswHvq5ix3XzlEOzNZhILZCZGRv2bfsjtV?=
 =?us-ascii?Q?KfDfEH0OmGWClIgSmTFtJucBjQ/8aWKWkVRPvYh2zWRdudypbiZ09tbkQr5r?=
 =?us-ascii?Q?ykmxT3PZMf5U6EL+9+KCbzPuajNYGlhQtqPlAIhX63e+FUwN/1mhWWpfgV5n?=
 =?us-ascii?Q?3/vrTXcTfAPFackgFP58+BMVcNQvluVHvl1LJdXtQmvW5QH4wsrRlN0GLVp3?=
 =?us-ascii?Q?w7Mx6H50n/IrgnKGzltxwU69a7J+EVJDPBw8WnqWJAGUAMGriRCg2rXc9d8Q?=
 =?us-ascii?Q?17hz9mqx7EUdQQSwBEC9HfuxHx30Lu6zi62ZXzo12J2DPWSEQ1uA+XT2KAz/?=
 =?us-ascii?Q?+X4ARULAP38ZoojI9wj3DUwwiyGj6ztZAn/qJ4f2T5ZFTweMK4hLVYtC4V4l?=
 =?us-ascii?Q?ICmLHyGasaq1YN3v9D0/3VPs1+Z9LbW+DlmiuZtCEbka7GY5QNafgDu2L98p?=
 =?us-ascii?Q?WNX9MCEt0qiLlrSS8NWsZKBa9CiLDdOkAEFY6IrobJBoKH61vgwct+h4Tt0g?=
 =?us-ascii?Q?N7whFuIx78Hq+9huDgdvKuCb38zO4MoPQUxtKELN62PFlblBr9YCp/vWxOlE?=
 =?us-ascii?Q?kRt4HXrYDPdi7CjPtSIQTBkk3lFXVUVm6iWhhruSTxYv46EW1NK95QWagian?=
 =?us-ascii?Q?uhJ3yOIf+G34w7or0gYGiFwjhRZMP63ZbRzePbQq5kA+EJmPIGuJpnNaWXHs?=
 =?us-ascii?Q?rL9eA1nGdqykGxVBegZ0NTIeGxBqiSPwhsGcErPQCfF2LrUt6SdUiZgCVbWI?=
 =?us-ascii?Q?A27q94+Cwa855RXE9rHnTs0oOV5eoZzSAnW6ilxey3NEeGLQCBiCxxBuzjT8?=
 =?us-ascii?Q?FubFH/pkoFZOFUjIRfcAJk7P0Z7Blt2Kk0fSKiOd1ulna4Tztm3gkHFFdRM2?=
 =?us-ascii?Q?VmSpkUjQwwQNpfU5+ZWMJontNMHqRXo6byTos9OFB0yBZa6KzFV9ijGgEGRE?=
 =?us-ascii?Q?U30tAc4CHToR/E7ZgjPnS7l4PvVklKGUgxpyNLHuafQX200mbQ/dsoH5suzk?=
 =?us-ascii?Q?O6WfNRQdVirTxaoilnsjVQd49bV+/F/QRPTiYtsFhE/L9Tp25yGx9s7GR+IR?=
 =?us-ascii?Q?TBPhxQLH+E5hnUf9yvJGQJAGY/XOfB4NOWD/o+/mLbH2wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 617d311d-487d-4878-37f8-08d98dde11bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 00:11:57.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Obgu81tiP+CWmK3xakp+KX3m+blsVI7bgtLVflNeuiNh0EvgsbKg/rMsQsh7haMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2510
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hWfzDrYzAnyax8s1mOOWCfptWNFuqe6k
X-Proofpoint-ORIG-GUID: hWfzDrYzAnyax8s1mOOWCfptWNFuqe6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_07,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 mlxlogscore=716
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 03:46:47PM -0700, Joanne Koong wrote:
> I'm also open to adding the bloom filter map and then in the
> future, if/when there is a need for the bitset map, adding that as a
> separate map. In that case, we could have the bitset map take in
> both key and value where key = the bitset index and value = 0 or 1.
v4 uses nr_hash_funcs is 0 (i.e. map_extra is 0) to mean bitset
and non-zero to mean bloom filter.

Since the existing no-key API can be reused and work fine with bloom
filter, my current thinking is it can start with bloom filter first
and limit the nr_hash_funcs to be non-zero.

If in the future a bitset map is needed and the bloom filter API can
be reused, the non-zero check can be relaxed.  If not, a separate
API/map needs to be created for bitset anyway.
