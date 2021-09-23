Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA58416895
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 01:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhIWXrp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 19:47:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243381AbhIWXrp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 19:47:45 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NNfrYr001494;
        Thu, 23 Sep 2021 16:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ugJo1CdHOgKZRmHmete9S6+xmY4bUVhtqEFTiT7oaEg=;
 b=pVXyBMaaMH8N5Hev5UIr5FcnpvhPUH1WxgWrBT4pggOM4QfcqgNsQy7EYOCJGwVU9nOp
 K82fJRYQHQIFdlGhe2w3oyDil/u+bA1i7erf1SCeuaFtp5CTp9ldtQXdOYbt4jSTH4fZ
 vax21U9RPq3xCHfltUNyZwxwEOTUWRsIzTM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b93fw00jq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 16:46:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 16:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKo/3CWC3vBHbxo8sj+ZagBetyLh4XULZfs0UcjrFm5y7ok16xBGomWHJrul4xFEKmQKxlwZz2eYrIPKcsbmReXXFZRavpvMIBdiZSirGKFz0kXXXkRSb2Bdhq3ARvbitDdr4blcCqzHUjXsAsv9O4OK/MrUQVoFHAi62VYZQlnhY4fGRKG/8pFNUIuktslP/khWTRkqKFpYq7A2BUx6Ew5V+fGfuik6J9W6QUNbtZBcKdMkNgm1n8El4LpYY7lAhO6AdvfFgLtLD6n4P/gLd24G03HIMSAGH5t4XXLaDZTQumIWG+kKE2mZe2psOuN/tCp1/jMBA7gN9t2R7qouKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ugJo1CdHOgKZRmHmete9S6+xmY4bUVhtqEFTiT7oaEg=;
 b=IsgDW8n1+jB4RvX3ZrIyH75Kck2hoK7lY0XqtdX0rNQeQiw98oSU2YLahKsTZrPauh1X58wlBDvFFg8qiTIHrQCp/Gg68kZ1QmPv5/0bwXMz7JbfiusTG+q6g/y2TjRVGKNjPNhM2MOLfqIQQjofxNMxUvqCjA0kpAoWdl8a+oXcxsZtV4tHf+MBRSUIuYTWSWB9X0/yEzqqQiC3CcTTJPNhpJy4SeswqJfH8XDYfIDeideXYw4sKmV3ScpoPp1vpK68wyYx7Ja6mEmjoi7mPGbIS2QbAN/PAWXLQ8hGtFUOHc1YzEqXJtf9vR1p1OlAFejNoKGsFQIW/VtgEffzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3840.namprd15.prod.outlook.com (2603:10b6:806:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 23:46:05 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 23:46:05 +0000
Date:   Thu, 23 Sep 2021 16:46:02 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210923234602.3pxuw3kzdayc675j@kafai-mbp>
References: <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
 <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c090:400::5:8ddc) by BYAPR03CA0026.namprd03.prod.outlook.com (2603:10b6:a02:a8::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 23:46:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de88ef6-07d6-4209-41c5-08d97eec4ef5
X-MS-TrafficTypeDiagnostic: SA0PR15MB3840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3840229D0F707BD5A7BEF0E3D5A39@SA0PR15MB3840.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xN7wqPKsLqIDHkdF92lz31yh+zZMKdO1D3E5nR47na3GtvzbBHWWQBXK1r66L3skUTW0JcJMczprSuD7rFxr36ouP35VyI15eVNwfotRG7mzC2zgMlhAj02LaBTsE6hURMVS43D8pnyOGzQrUxWIizIhkXflEm7Y79EPLuIl6i6dO30dExrtpuBnDNMQ+23kCk3KYtDValYJXkeDQcYj6DVGGnc9g/0Y2Ci8dJQeMZtabVRKGkbHxclaQDyMCWhROFv4k4Mij3LX2G+TOlKKxOFU6FCU+RpM5gVQg7xCu/nSDn04L16DSFIv/W4D3tmpzSY9I8keaI7feIDGtMXRCaIQxB54LW3QMPw0wdI5hsVrSxFTx+ewLPOmH1Jh8lEuLoXGec5nyL6yGTuuexC86y3ch4jtQNO9VsiIcveEEUmGLTYuU2P4R3dh6WikBGw5J1ObThWsnwfLxtTFYem9PZ4AXXH9wRir0Pv8XAum4GbM7Q8XCRZ0niFW8A3m8eqAcGpfWZ08SWTSXSy7IuHO1vxxGLkfFVOONLsPk9BZ1IEcS3Pnj/YXw06nfsBN8VGWZ/H1zqIrVoeMe7p0sfiYaN//E9Ed8scAsELdF9XbTYtdwD6OMnAeBnd1QVs0OSU5vGzK7ZQsw0EOUs0z2q8sTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33716001)(316002)(9686003)(4326008)(6862004)(52116002)(6496006)(38100700002)(54906003)(83380400001)(186003)(66556008)(66476007)(6636002)(1076003)(8676002)(5660300002)(8936002)(55016002)(508600001)(2906002)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ouL3CDzE92lCZfZZDaEvD90tM3onDwtjYnjXcPHcYL5l9zlz+8R3IBTPQxLf?=
 =?us-ascii?Q?RmpEYwWVT3FSnMPSePSsYnMugWj7UcO+eEkDk0uFgeLbF9PZtvO3TP3zM7E+?=
 =?us-ascii?Q?DDhkp4cwA47/rt/yNMeGedsAgrJhmfrOgPonLeZcxllkNCIiEEwTbTKwql/W?=
 =?us-ascii?Q?VUknSVfqKNIIUr38e29brI9Y+f7kyN0LM0NKU4dRAUipgH/0+Jx2lxtkMRL5?=
 =?us-ascii?Q?8m39A/GWFxHhXs+fn+BFLeoF0pIZ5HXxrk9WHADRz31D1cRLXAUR26Gk8Jay?=
 =?us-ascii?Q?5bQBI84qZnNkgYinBgkH7G9n8Ly0wRjR5uoZ7uIcUbQ1V7aHxGPNmAaAb0vb?=
 =?us-ascii?Q?ocnGn1nXSsC3lIm4YboOrf0Ah9M5YrakOUAX/7Eqn/QyLBpLXU9963LmZvR4?=
 =?us-ascii?Q?9Akh/yZmda12kpvzh3zLK+M2mT6KR+5le73kRI+8eN8oq0Ji8tfD8kZ7zZlI?=
 =?us-ascii?Q?uwVXXCY+zlonyxZk4aTCDcetGh1pSvhorytCo9jwuqL5QLbMZxWFBdU9xI3F?=
 =?us-ascii?Q?QyzUth4kWjcRDXBDyadHb/lm1tyIebpToCwk3OxzcH1mRtYsu5KUMhEilaut?=
 =?us-ascii?Q?MS1HNDMLTvBzDzpQwlbwIMHEJvfDm1CUdQ2a2fDKvbWdDUinJYaOXDdNRxKK?=
 =?us-ascii?Q?/a+s/ZYVuWrUXuxa/Fb705B5c5u6+N8/vaX2tc2CoEyJXaKfuH9vJ8GejVy3?=
 =?us-ascii?Q?xodwUPmqAivGWMjg4NGE4rrClSkPFx2vvbUFVVESNBxzeAlhcs0a8qaY35wE?=
 =?us-ascii?Q?YD4m4q9xIUMk+PIy1e77g5axKUqCCn3WE4WxbBrddkN7FkpgbNhaY4DdRPRy?=
 =?us-ascii?Q?+xO16Iu74cB1ce+EtV1nA7WutndLejJxFnj0JxOHulUmkxXPADJZT14yHehQ?=
 =?us-ascii?Q?AZdTw5HIM6ATJpLv6U3QVWrmwnRn0h1SiVbusdIe34sBJm2r0vpbtyyKG4bk?=
 =?us-ascii?Q?8fNHdwT2u6NKKgcyk8d69zCphTSftdToDKBL9M9ACL20Vcikl98drmcZa3fb?=
 =?us-ascii?Q?1fNIlFH7ACR6LHyobHcEeMnT8xeq+08NLwE42wO6P4efTfcwRME4ExpovRXF?=
 =?us-ascii?Q?qKmBfALsbNZtm69NC0Pj+fujNM5UFS7TXQMARaijFMO2wi+sH9/8K2uGFMqm?=
 =?us-ascii?Q?n4SMA++ygO30GGBqcYT31FHSyQTkluLtFibNkRvy/bQLr2g7Du2QEXeCoJcd?=
 =?us-ascii?Q?0RDBuXsX+TnM+bOCCpdpxuAcOLDowLrC5PTV3pp8qsAve3xYikFDxB5iRiXD?=
 =?us-ascii?Q?QajpMoceO2hNS6NSr8RWOND/L9LEQy7+R+Q+pE51enJIsXFFW9MRkMc9zvgk?=
 =?us-ascii?Q?fc5rAvp/jhMiSxIxxKNvrrdOIYSB6Hh68EWHmM3/Cq37TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de88ef6-07d6-4209-41c5-08d97eec4ef5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 23:46:05.4142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnYzvhatA8vB3NRKYsVod15CrcyZ1KPaErDF4IuSTwI4F6XZTaLwmfhuDsb6w5bH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3840
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: PsLqCNDH1YyYG84N9rogmoRXcib_Bxwd
X-Proofpoint-ORIG-GUID: PsLqCNDH1YyYG84N9rogmoRXcib_Bxwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_06,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=960 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109230139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 03:28:01PM -0700, Joanne Koong wrote:
> > > As far as map based bloom filter I think it can combine bitset
> > > and bloomfilter features into one. delete_elem from user space
> > > can be mapped into pop() to clear bits.
> > > Some special value of nr_hashes could mean that no hashing
> > > is applied and 4 or 8 byte key gets modulo of max_entries
> > > and treated as a bit index. Both bpf prog and user space will
> > > have uniform access into such bitset. With nr_hashes >= 1
> > > it will become a bloom filter.
> > > In that sense may be max_entries should be specified in bits
> > > and the map is called bitset. With nr_hashes >= 1 the kernel
> > > would accept key_size > 8 and convert it to bloom filter
> > > peek/pop/push. In other words
> > > nr_hash == 0 bit_idx == key for set/read/clear
> > > nr_hashes >= 1 bit_idx[1..N] = hash(key, N) for set/read/clear.
I like this bitset+nr_hash semantic, then max_entries logcially follows
the number of bits.

> > If we do the map, though, regardless if it's bitset or bloom
> > specifically. Maybe we should consider modeling as actual
> > bpf_map_lookup_elem(), where the key is a pointer to whatever we are
> > hashing and looking up? It makes much more sense, that's how people
> > model sets based on maps: key is the element you are looking up, value
> > is either true/false or meaningless (at least for me it felt much more
> > natural that you are looking up by key, not by value). In this case,
> > what if on successful lookup we return a pointer to some fixed
> > u8/u32/u64 location in the kernel, some dedicated static variable
> > shared between all maps. So NULL means "element is not in a set",
> > non-NULL means it is in the set.
> I think this would then also require that the bpf_map_update_elem() API from
> the userspace side would have to pass in a valid memory address for the
> "value".  I understand what you're saying though about it feeling more natural
> that the "key" is the element here; I agree but there doesn't seem to be a
> clean way of doing this - I think maybe one viable approach would be allowing
> map_update_elem to pass in a NULL value in the kernel if the map is a non-associative map,
> and refactoring the push_elem/peek_elem API so that the element can represent either the key or
> the value.
> > Ideally we'd prevent such element to
> > be written to, but it might be too hard to do that as just one
> > exception here, don't know.
I don't mind key or value also.  With nr_hash == 0 and key is
the bit_idx, it may be more correct to say that bit is
indeed 0/1 instead of returning the bit_idx back.
