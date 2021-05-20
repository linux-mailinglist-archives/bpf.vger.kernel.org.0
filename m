Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667EE389FFD
	for <lists+bpf@lfdr.de>; Thu, 20 May 2021 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhETIk4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 04:40:56 -0400
Received: from mx0b-00007101.pphosted.com ([148.163.139.28]:51912 "EHLO
        mx0b-00007101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhETIkz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 May 2021 04:40:55 -0400
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K8DLdx027931;
        Thu, 20 May 2021 08:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=references :
 in-reply-to : from : date : message-id : subject : to : cc : content-type
 : content-transfer-encoding : mime-version; s=campusrelays;
 bh=P75OHpbGg4gLc+T2xmZ5Jksku6+PqUCNPll9iVaZ4uo=;
 b=PsxnFP1i9vMN9c1YTFZ8p8C2B6GnEzqELTEphlSnAE2oZiDvps2IFOImIQ5mGZWnS3yV
 sp0CZIaW2SXL5l2TZJUtuxFhceMuQP+a6a/snUb1j852zLEpRgcRbSPSh0LhBbw4hM1Y
 KO+vjmQTNwTEbRy/c8+Gx8hWFlD5ohCZmTE1FhP5IakEg3BwXkMCsXD+gRvm/YqRb41N
 NCe8paPRh7IlJV2obCjF08g9OYkwfZOGwQL5XSx822md4+PyUFvHHNK0767RtrEEfyES
 08NNg8wMYjedqDW8UrjjameSYuYfDtzlV2rn9jLpPS5etMwzFJ3YXLrBxc869i1hj2af nA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0b-00007101.pphosted.com with ESMTP id 38mx5ntufr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 08:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc45QEPERKEOuXuSlcgkHc9h1RrvVUzm31+eaTegodPhJ5JnKaNUFEJPZBQkQ9kk8L73jtuF6VH318B8BTg/TU7k4eNBxHGVpUuuYo4cisLLgwGrtL6C3rmvejYAsAxsmVPLAHl9k4pkjG4JwctaIOKP+LWqhSh5P7G4BIFvGYa1G9mEcOAZeNvWdN9W9vxirWyPTqozR9kVk53QMEHBgudBu7YEz5KIbh6ymbv7vVvZDry6aVQvlPiA94Ql6v63EiDX2ukUZEWjAIuJXhQEmXdrg/dDuk84RQlvf/HcdElO44aAkuYSisPP/C6ozQY27ed04HfuNaEjU/pMGcrOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P75OHpbGg4gLc+T2xmZ5Jksku6+PqUCNPll9iVaZ4uo=;
 b=Sk30JI9U7V0wkPk7fOJ9bmiF6jeIFdsxR5g9HIcNT4QePxLxYV5UygRkiqm92MEYlUJb5E3LssL105uBexxt5Bfvd1AZX2uHGD2dcPGCnnyBXBRgSmq94yhL2DANbF6DJve+oUd5O1M3SuD+C3E77s5EBTPaR156CxdYdxfcTFVwo0hVxxXQsSWcc5e3YN/hKtIlQCOu3i7Lzt/6nmMb5XxnwdJlgqFEQIuwS80M+UShCcnRvjE1sTlCN8LJ32CT9hC9wqvZ2mzT7Fday71Xv4Gz+mDIpOu+/b9ZoCPWAuJnsTUe8FYUVYxmPR0Tst0Ynlqeiob1Uf8ji6YzRK4ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=illinois.edu;
Received: from DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) by
 DM5PR11MB0028.namprd11.prod.outlook.com (2603:10b6:4:67::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.29; Thu, 20 May 2021 08:22:01 +0000
Received: from DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::21bb:c117:6de2:2ac8]) by DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::21bb:c117:6de2:2ac8%8]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 08:22:01 +0000
X-Gm-Message-State: AOAM531DIz3gpRdpthnsU4Vsnj1GnyMf+9rpkgITNR8TVv7YQaB9CEwi
        fjWmIwNsLL5skOA4ZgHFLz4DKqhOoGx/TK+40GY=
X-Google-Smtp-Source: ABdhPJxd/76h6hYsz+j3RRKhpoZcDWb6NzUjNdnETEnB99o2ViLI/AGQQmtBUeDNAB9TlGnr5E4zvP29xquv/Z6leak=
X-Received: by 2002:a25:38ca:: with SMTP id f193mr5491303yba.422.1621498581249;
 Thu, 20 May 2021 01:16:21 -0700 (PDT)
References: <cover.1620499942.git.yifeifz2@illinois.edu> <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com> <108b4b9c2daa4123805d2b92cf51374b@DM5PR11MB1692.namprd11.prod.outlook.com>
In-Reply-To: <108b4b9c2daa4123805d2b92cf51374b@DM5PR11MB1692.namprd11.prod.outlook.com>
From:   Tianyin Xu <tyxu@illinois.edu>
Date:   Thu, 20 May 2021 03:16:10 -0500
X-Gmail-Original-Message-ID: <CAGMVDEEkDeUBcJAswpBjcQNWk7QDcO8BZR=uvVfm-+qe714tYg@mail.gmail.com>
Message-ID: <CAGMVDEEkDeUBcJAswpBjcQNWk7QDcO8BZR=uvVfm-+qe714tYg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Jia, Jinghao" <jinghao7@illinois.edu>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [209.85.161.52]
X-ClientProxiedBy: SN4PR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:803:2e::34) To DM5PR11MB1692.namprd11.prod.outlook.com
 (2603:10b6:3:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-oo1-f52.google.com (209.85.161.52) by SN4PR0201CA0048.namprd02.prod.outlook.com (2603:10b6:803:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 08:22:01 +0000
Received: by mail-oo1-f52.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so3611606ood.2;        Thu, 20 May 2021 01:22:01 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce2d921-5bdc-4076-3f47-08d91b6857b3
X-MS-TrafficTypeDiagnostic: DM5PR11MB0028:
X-Microsoft-Antispam-PRVS: <DM5PR11MB0028766F2E11FCB530D2DE8CBB2A9@DM5PR11MB0028.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +e4vfZVjPDFopIHPDfFiVWpz7by2X0l8g7wzzDWSEwxgUQHkV/fjkyyBF8GhI9/O28XiUnzfgcip2pTm1irzDDP0spg02O65cmBMYz/8sEKgEIO7Ib1j6iiN8gaK+Q/YUBmotqY3GYmEOTT5NDfr5ctgXfWuX1yOXAIiXD4sma0fKBozQHrdxdpmc/iaaeHtlFS8qGH825X9pLJecdbUeMKz8TnqSeItWERF1gUVOm/gVjQ9vGkPD58FBfoipRHO55qPCjR4c94UISyQLoRcfwV4EREWR+ZLWgUXl25g5pfXKrOmWe85/VQ3JIjmZmPh9uhTj7lF785Ng2ZKgZTwbimmw0pGm6NVvzvZCYNPVDvoDZJWxLNJknpo7uIVCLewuQDGslzW06FU5aX599XGQFmmwj9Naj6mEPTKTIoJBLr2hbAywQyztl/IQLZ2GGQL0meaT5+R6ZfHpQFBNP5q8VC9d4HVOVhPyrKzZbkm5Gv8VdAerNJ8oNifxqi+7D9hG2ollWOuB9vtwA60v5m9/HWHSTzrN/SpyvEN/14EYnkOiWlmIDdQeM72Zed8o/gvU41CT6oNalsltkYOqMlW14M8rUbjRN5FMXVkwybYMoXxZZESGaEz1pJsBZyVIt8CYVWALjNHKxISSMzDXwoqRIcZ2rHzy5zCYrIjPyPmfizuXAvd5wXjZ1yqcLb/sB5sjBt7LOTInHTzWqeO5qjQNIaZd4Qx/085fq52kHO4h0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39850400004)(346002)(396003)(376002)(5660300002)(66476007)(42186006)(186003)(316002)(786003)(75432002)(54906003)(26005)(38350700002)(38100700002)(66946007)(4326008)(450100002)(8936002)(86362001)(6666004)(478600001)(83380400001)(966005)(2906002)(9686003)(52116002)(8676002)(66556008)(6862004)(55446002)(53546011)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWREMXpseDhpTkNURkpSYXZNZnFCcjMwc0NhTHluL0hnSWcxNXluRDYzeUlO?=
 =?utf-8?B?c2hIcFZHWTg2T0I4eTFIa1RxNlBNdWZNemE2RFJVbjZHMmhzUFh6bG4zMmNM?=
 =?utf-8?B?YmZxWVNsdTR0dC9QQTBQZjFWUUlzS0tBWVBnLzVjdTYvMTMySldwT1J2dEMz?=
 =?utf-8?B?UEM2Tk9FbE8xQkdMYXNGUDEzaXhUVTU4MGxic0NweGJRNVVzT05nWCsyNXUw?=
 =?utf-8?B?bFR6R0J0SVRHZ21SM1p0b0dyS1UwVjlIc3VUa1JVSStuMkM0c3lWTXh5TkpX?=
 =?utf-8?B?b29remlBS2h2MUxwY3h4UGlpSXRwN2ZjTzN4dDBmL3UvaU5sbGR4YzZ5SnQv?=
 =?utf-8?B?QUZqRUt0SjNCODlDNW00dnJNVzZjbDJsN0RKNWpyM2ZEVWpaS0hRYWZvVk5S?=
 =?utf-8?B?VzdVUXJFbW5LaWxBaERNTjJqZkcvbWNpM2pQN0w4eWt4cVFtdGp3bTJnYk9z?=
 =?utf-8?B?MEUwNjRYUUVqMVZ2RU81YXdvZGlUVVMwMC9SYVo1eFoxY0pPQ3JtVHdxUXZ3?=
 =?utf-8?B?enJNc2dzbVRhajFHOFp3QW5ocFlJMXZ0d3d0SlZ5NlNiWVNoZ0xDYXBaYzA3?=
 =?utf-8?B?dUtzOFBXYzJKOHFrdWcweW5rSy83WUVZNllOZXBHSmVtWDArUXlGL2VJOVh1?=
 =?utf-8?B?R21KdFViNkdpTnJIeVJnU05JdHh4SkZ0eWlseFIwYkFYaS9FQTFBMDRwQ2k3?=
 =?utf-8?B?bjBlUkl4MU0wR0k2alI1SDg3cHVJWms5azd5Z01UNGtqRkxoYVVoZ0RTSGpH?=
 =?utf-8?B?UFVzTitNYnp3OHk3b3daQ2w5Z1krSElFb25yNlliVzZHS3FlYll3RitSY0x2?=
 =?utf-8?B?NkRGVHVNdm9BTWxTREhtQ0JqaTdhZkN0SmFSVGswZUlIcm9UemhJZVR6QUwz?=
 =?utf-8?B?TjQ4dk1ZVnluSVpZSEV0WlFNYUZOZkVCQmtUYWEyTWR5K0hTQTJvYW9yTzRK?=
 =?utf-8?B?VnR3T1ZjdzZidzJXRklvN0NBZU5wUGpTSG5WRC9BYlB0ZzhYbTNha1hFc2t5?=
 =?utf-8?B?b0NYNFRQZVoyelpORjF1SHFNYnQyTVhDZFUyU25QSStvTHVMeE0vdEFRM0JO?=
 =?utf-8?B?S1JKdTlMZTMvaFY3bnVsSUgwMVpTNnNPTmN0dUpxeEo0WHl3Q1k5VFYyb3ll?=
 =?utf-8?B?aGlyTjZjTi9nREJSNGtTQ01tU25DSzRCS1BBOE4zS0p0NlhPTGRWc2VIOUg5?=
 =?utf-8?B?dHM5WHhtbS8ycjQxcVdEakVHVW5JUUhjRnFaUzI1T21BOERBWTczb2JzQmJB?=
 =?utf-8?B?UUo3dXUzZVd4aXRpVVlmNWM1cVY4bVZVUTRKMXZVZXZ2K1hETTNPRDJiOWZi?=
 =?utf-8?B?cHJrako3QlNkT1gvNDh4dGxDQkhqVXZPdm9nVXZ6ZVBTTHhRRjhVeld1WVl1?=
 =?utf-8?B?eUNhTEdpL2xuNW9YcGtDbEx1ZlphcEVZS29aRUU1Y0FXRW5ubmI5Tm5BYnhC?=
 =?utf-8?B?Vk1TdS9jN1FhNmNkKy8raDZOSzE1MWhadFkvcUloN2ZqYVhqWjJJNmZma2do?=
 =?utf-8?B?ZVFsKzhJa1J0bE5CWW13MnZ6R2gyNG1oNzlLK1JEQWhSU2xKbktuY1V1bzJJ?=
 =?utf-8?B?ci9vVnpIa1Uyb1ZyVEl4ekF4ODkvZVRsVGlnUkZnTzAvcTgrQ01wdHNzL0Fi?=
 =?utf-8?B?bWxGMENmWWNLc0dpcDMyWXJlaHFuRzNKKy9EbHlTMWwyQmtSdC9uc0cyMXlY?=
 =?utf-8?B?QmdxQUZZcEZENTYzVE1kUkUxMWljeTNsZkdIQWxzWnpWZUFzZzZyQkhMU3dK?=
 =?utf-8?Q?io1+EUPspf7aKoK9rEQutsbDn6hyukEoQ3cCucZ?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce2d921-5bdc-4076-3f47-08d91b6857b3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:22:01.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcLczjOakVDGtM+Y/mIfuVhPs8eQUuRpLscnZmYUxwH8O1eg8ENZavllqo8DF9kmQJHaHbguhpn5sdrQQS48nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0028
X-Proofpoint-GUID: fG1UmPqJDhS0_XAUaF6DJeW9_93jbTLD
X-Proofpoint-ORIG-GUID: fG1UmPqJDhS0_XAUaF6DJeW9_93jbTLD
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200062
X-Spam-Score: 0
X-Spam-OrigSender: tyxu@illinois.edu
X-Spam-Bar: 
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 17, 2021 at 10:40 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Sun, May 16, 2021 at 03:38:00AM -0500, Tianyin Xu wrote:
> > On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> wrot=
e:
> > >
> > > On 5/10/21 10:21 PM, YiFei Zhu wrote:
> > > > On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> =
wrote:
> > > >> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com=
> wrote:
> > > >>>
> > > >>> From: YiFei Zhu <yifeifz2@illinois.edu>
> > > >>>
> > > >>> Based on: https://urldefense.com/v3/__https://lists.linux-foundat=
ion.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAoRgmC=
eWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
> > > >>>
> > > >>> This patchset enables seccomp filters to be written in eBPF.
> > > >>> Supporting eBPF filters has been proposed a few times in the past=
.
> > > >>> The main concerns were (1) use cases and (2) security. We have
> > > >>> identified many use cases that can benefit from advanced eBPF
> > > >>> filters, such as:
> > > >>
> > > >> I haven't reviewed this carefully, but I think we need to distingu=
ish
> > > >> a few things:
> > > >>
> > > >> 1. Using the eBPF *language*.
> > > >>
> > > >> 2. Allowing the use of stateful / non-pure eBPF features.
> > > >>
> > > >> 3. Allowing the eBPF programs to read the target process' memory.
> > > >>
> > > >> I'm generally in favor of (1).  I'm not at all sure about (2), and=
 I'm
> > > >> even less convinced by (3).
> > > >>
> > > >>>
> > > >>>   * exec-only-once filter / apply filter after exec
> > > >>
> > > >> This is (2).  I'm not sure it's a good idea.
> > > >
> > > > The basic idea is that for a container runtime it may wait to execu=
te
> > > > a program in a container without that program being able to execve
> > > > another program, stopping any attack that involves loading another
> > > > binary. The container runtime can block any syscall but execve in t=
he
> > > > exec-ed process by using only cBPF.
> > > >
> > > > The use case is suggested by Andrea Arcangeli and Giuseppe Scrivano=
.
> > > > @Andrea and @Giuseppe, could you clarify more in case I missed
> > > > something?
> > >
> > > We've discussed having a notifier-using filter be able to replace its
> > > filter.  This would allow this and other use cases without any
> > > additional eBPF or cBPF code.
> > >
> >
> > A notifier is not always a solution (even ignoring its perf overhead).
> >
> > One problem, pointed out by Andrea Arcangeli, is that notifiers need
> > userspace daemons. So, it can hardly be used by daemonless container
> > engines like Podman.
>
> I'm not sure I buy this argument. Podman already has a conmon instance
> for each container, this could be a child of that conmon process, or
> live inside conmon itself.
>
> Tycho

I checked with Andrea Arcangeli and Giuseppe Scrivano who are working on Po=
dman.

You are right that Podman is not completely daemonless. However, =E2=80=9Ct=
he
fact it's no entirely daemonless doesn't imply it's a good idea to
make it worse and to add complexity to the background conmon daemon or
to add more daemons.=E2=80=9D

TL;DR. User notifiers are surely more flexible, but are also more
expensive and complex to implement, compared with ebpf filters. /*
I=E2=80=99ll reply to Sargun=E2=80=99s performance argument in a separate e=
mail */

I'm sure you know Podman well, but let me still move some jade from
Andrea and Giuseppe (all credits on podmon/crun are theirs) to
elaborate the point, for folks cced on the list who are not very
familiar with Podman.

Basically, the current order goes as follows:

         podman -> conmon -> crun -> container_binary
                               \
                                - seccomp done at crun level, not conmon

At runtime, what's left is:

         conmon -> container_binary  /* podman disappears; crun disappears =
*/

So, to go through and use seccomp notify to block `exec`, we can
either start the container_binary with a seccomp agent wrapper, or
bloat the common binary (as pointed out by Tycho).

If we go with the first approach, we will have:

         podman -> conmon -> crun -> seccomp_agent -> container_binary

So, at runtime we'd be left with one more daemon:

        conmon -> seccomp_agent -> container_binary

Apparently, nobody likes one more daemon. So, the proposal from
Giuseppe was/is to use user notifiers as plugins (.so) loaded by
conmon:
https://github.com/containers/conmon/pull/190
https://github.com/containers/crun/pull/438

Now, with the ebpf filter support, one can implement the same thing
using an embarrassingly simple ebpf filter and, thanks to Giuseppe,
this is well supported by crun.

--=20
Tianyin Xu
University of Illinois at Urbana-Champaign
https://tianyin.github.io/
