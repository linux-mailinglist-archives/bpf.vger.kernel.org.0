Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A1285822
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgJGFeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 01:34:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgJGFeI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 01:34:08 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0975XpgW018996;
        Tue, 6 Oct 2020 22:33:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=w6QXpC/qqQzkq3WM1kQ9v7Zs3PbicW12SnCosNAdVnY=;
 b=bFuu1zSnxqJ73YgV1ZTYPY/VTnWjyVgtoXvu4gSVObnwgmF9d5iOAYmPkycOBPU5bqhx
 m5mVSiMr/v+efBHBjcFVQdwmtEDKhUOcJ7SCSD4wZnzm/Lux9gyQhXr/xlR+2RCCFfLg
 OjyRTDN+oY+ZY6ChS0Z9bCCvkjbSbrG9ToI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33y9jnxj8x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Oct 2020 22:33:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 22:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6DFJ9mzyuVRMUwd3gFYJe9BxPM6B084kf2RLSQwEnyluxIeP+PS68uE0dOHsGq/DA0eXEiM0eFBU09VxokWMKi20/phpDuWusWqrEb0+g3bA7zoXQWZbl/0Drgb+bztiXwkttPg3mBzDSgpAHFLHOS4vT6l6Ws5JIdfnJ2biJb+xoIQLvh/QIZF6Zs9oIUnfCDwCgRTgyPUMmVL/DY41Uo1HeYZY/uFOgmAAESDU/agMarWUzGrXsRLRSWBcU8AIGYehdNnsY1S92HPUr9PuSviehiYGBsf93JvjB8HLPdoSbD+1pWVKzPUI2DgGv06zdGSJ6yTQTQxY4Gvy9ka/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc32wX5Rft8ZKuX0A6o5+lQ313Ouo3WE8MZdjcVO2X0=;
 b=T8rNyaLUI9gLPmVQyprutQ7cDDdWjiNhjFAw5IaB9KsQnsZmQITxvvE0lK4rdFnEEZEQ56w9AYgO34tW3kKnvwTION+O+ymUCMCdLgbPa4YRGoXnYBpER192A0saCJ4kvkQ9MZvV4X+jnRVDvVA5D6VV0bR9NQlMYlGFKw38aaiyYaf2VnUkxRgUWuYM2fMhTPPQbgTAk/lN2dG+b6WS9H5RommSLqQ3PkqndIhba/kPecqa9U9nnPk1NyyAeo9i5F/Qd0HIHSDDADRyes8s5UzCJARhEF4W1OYxiL7dGBdR56PRPWFcfNN0BC5uJ0o6bZ47BnaHFFhJyrVZjESqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc32wX5Rft8ZKuX0A6o5+lQ313Ouo3WE8MZdjcVO2X0=;
 b=RsGnowREyjc/Kxudk6+cW3OxDq2pVOUUfx++cmB1nj7RyunONJpDM/MvWPquFbAmlALY0qzXVEcolg+pV7aKjQdJdUTTT3hXYw7zms9J/VCvbL6d0ME05+TR2Rq9TftIappZB6savPN6e9CzLhqoNwxEBiTbk8gnKbDZJog0PoE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2647.namprd15.prod.outlook.com (2603:10b6:a03:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Wed, 7 Oct
 2020 05:33:28 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 05:33:28 +0000
Subject: Re: Failure in test_local_storage at bpf-next
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
References: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
 <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com>
 <71e1203f-5864-f86d-e587-67d92183b89b@fb.com>
 <CAADnVQK1v7vz-AQfw2OcUD4tD1wesSdzaRA1bFvtm2ae3fLwAw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <549d23c4-bb83-2116-fb51-293a043e6f21@fb.com>
Date:   Tue, 6 Oct 2020 22:33:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <CAADnVQK1v7vz-AQfw2OcUD4tD1wesSdzaRA1bFvtm2ae3fLwAw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:757]
X-ClientProxiedBy: CO1PR15CA0069.namprd15.prod.outlook.com
 (2603:10b6:101:20::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::121a] (2620:10d:c090:400::5:757) by CO1PR15CA0069.namprd15.prod.outlook.com (2603:10b6:101:20::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 05:33:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec20b51-1221-4038-caf6-08d86a82848f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2647781DAA76AADE74CD163BD30A0@BYAPR15MB2647.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C70R1Vykt2JYgiwuWNWQAAFPwKa37zsutzq6+5WAxtNaxlnDHaeSscowRXeO9D54ZW5+/kDOZuMTZ6w/IRDNLTXtLfYfKiTssVkFi1M/HiudNze/QmnIPFyN6DiwYQqfuT+fzwIzR06Dd4MeEvtEZAjA+SvwGFli0LvFy1nj47bmwvvz8Oy35CwR7UCYAW5Z6gvcuHmUI+kfxFfSpTPfOI5JzsUR88iKziDTSFkLS+0v76uKkuhUDU60/3LP3vL1LIHng8JRfZjlnnqLQROvCXmRVJ0MQOV6BQGikrTM/WfOuvQQql5nR0pQIQPf/7xX9o5Bmjq8LMP8bnn4bbI70dzQ9ec4wTPtQtO2yOwIuDZLJuoH4Uig1Uqve75BOCOJyYC+Lq8jzfsM+YpAGcLotmgdMg1goYJO1MuI/N4GpfDIPLmC99JO2JIWA0BVqI4hhdAOVFPehSbJ0UVT42oXkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(2616005)(83380400001)(54906003)(83080400001)(966005)(66946007)(66556008)(6916009)(66476007)(4326008)(478600001)(36756003)(316002)(5660300002)(2906002)(186003)(52116002)(31686004)(8936002)(86362001)(31696002)(8676002)(16526019)(6486002)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZUqOt9v/3DQ7cegouG9ZY7cwkPBr7Ki3hABEtKmIm5R2s7xM5AfyaNPmJ5VN/mN94TlVnWHhd+Q9KJljewoEsRJFswRPW+n+Vd17cx92pIdM/TfT24M39gAREY4x51aik7VLEEZShH17Ii43X+WvYhbl8e75iwt/8Hqgp9d4lGakVHLQVrejtv5RDDqIQ8fSoR385m/L9/Zsb22sjCkmiHt8C+AaUWJSApqK+ez3/hQUsGKj0CajMFJPXyoTHe7SuwMD7auR4t1P/ikrCSZXsECKI3ue7mVnuI/ArnWQFe/xbM7TCgaDOQ5ltI5blEA2VVmdKpsLByNU/817Il656MUW5OIrQvpFcVLd+ihILsHiFSKQRh35Eo7ivF2VAEdBn4lotIaY67k382H23Tr6itAtMN2KLrGB5L+RzAc1U6+NyWaJZkEyd5v/y46Bn5DZ6WgNk/x8fZ3bPLWTSoAiUFQJemeQazbLX/FNYmQP+YnCaWUzZPWYd3iP00kKZ4oz25wGO1d7EQxMFrzlGK9KGLLNPuVYbbDWTvpd/kjcaVjRvGrAXpN6OMDHhgR1OWSPTSICVyT32Yz1Cy+nIu9J/lca4pOeHAoJys0Ll9jIP6lQ5ifo+hDeo6XwbqZkSySWihocosrec/oLzN/x81pv2Z3fgtZhCDwaGHHJY3mBb8Q=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec20b51-1221-4038-caf6-08d86a82848f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 05:33:28.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z50lbXRK7xp3wHHHfK++9tM/0ZIc5V3cLjcZ+cnaI2/Dshic41me7V7P1Fgpj/hh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2647
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_04:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010070036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/6/20 10:18 PM, Alexei Starovoitov wrote:
> On Tue, Oct 6, 2020 at 9:31 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 10/6/20 6:23 PM, Andrii Nakryiko wrote:
>>> On Tue, Oct 6, 2020 at 5:31 PM KP Singh <kpsingh@chromium.org> wrote:
>>>>
>>>> I noticed that test_local_storage is broken due to a BTF error at
>>>> bpf-next [67ed375530e2 ("samples: bpf: Driver interrupt statistics in
>>>> xdpsock")]
>>>>
>>>> ./test_progs -t test_local_storage
>>>> libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
>>>
>>> This line is truncated, btw, please make sure you post the entire
>>> output next time.
>>>
>>> But, this seems like a bug in Clang, it produced invalid access index
>>> string "0:0.1", there shouldn't be any other separator except ':' in
>>> those strings.
>>>
>>> Yonghong, can you please take a look? This seems to be a very recent
>>> regression, I had to update to
>>> 6c7d713cf5d9bb188f1e73452a256386f0288bf7 sha from not-too-outdated
>>> version to repro this.
>>
>> Sorry. This indeed is a llvm regression. The guilty patch is
>> https://reviews.llvm.org/D88855  which adds NPM (new pass manager)
>> support for BPF. The patch just merged this morning, thanks for catching
>> the bug so fast. Since NPM is not used by default and the code
>> refactoring looks okay, so I did not run selftests. But, yah, it does
>> change some semantics of the code...
> 
> but llvm tests were run, of course.
> Looks like we need to add more of them, so they can gate the landing.

Right, just added two more tests to gate this particular kind of 
failure. Also just pushed a new version which is simpler compared to
previous version.

> 
>> I just put a fix at https://reviews.llvm.org/D88942 .
>> Hopefully to merge soon.
> 
> Thanks for the quick fix!
> 
