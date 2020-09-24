Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BBD2779E3
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIXUG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 16:06:58 -0400
Received: from relays-agent03.techservices.illinois.edu ([192.17.82.70]:39802
        "EHLO illinois.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726183AbgIXUG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 16:06:58 -0400
X-Greylist: delayed 1080 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 16:06:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=references :
 in-reply-to : from : date : message-id : subject : to : cc : content-type
 : mime-version; s=campusrelays;
 bh=/eDeqaFyUH+t373rLitrTZEIIaPUpbaRV0kHjAm9kjE=;
 b=JtAhWbmh7v/UH98BbWW5+W/NwV77m+uLYAtyxBqBXDaJHYiSyk0B/DyItK0EYH4u8O2K
 TiEabP8aa+GFJkvwrPG3A53rvNBRG6rxp5d/dw50T5rBXBsY5obuanS3Al4AN9Hk+W0f
 XVJMi/1lePj6LCc/O7wbPqjXe5t63RPsfJ5Avh7vqz/uKmC3tqlSE0AY321lvTXr3HvW
 X7GkzwFTtnc/jfKuleexqkuIkRr/csrsVn4zNYHUyHxWIUfVyZ/wBZ3F1Zhz1A78bWtO
 tJIdOa29AH7Ip2SSfmdZR8Rlv5xeHPTSjMCdVzI3uRYXQ9r3W/eQMRTme1xGH7sPPC9G 4w== 
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by relays-agent03.techservices.illinois.edu (8.16.0.42/8.16.0.42) with ESMTPS id 08OJmsGZ013552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 14:48:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+yC8EeCFtxyT33LaBA5xrq4muwINwrPEhI7p011lFPkPzOz2pdZ4/fcz0vqsXsLqx2tkIi+qVZCoNzVpD5310EIs8LV8raKY/IHgd9V25GF6eXjsaFgDRTC4a9/QNHhJXk20KkZtyiFoJapftMTO1aTGux3/5xqFD2WCKPGPP6C/SjoClZhrSc8lpgCptJSZ4CDlvn0fKvMOpCKOjf5+hvfuK8c4VRa1mpKPn3/NxUHuAAB6FJLnfUqnXAnXC1jSRcSPw1JM5MANlO1FYrxLpGXgc3ahSEPATPNGOcv+phr5v8TyFv+X35Q4wf8FdICa4UJzMDtWBT4IBx72066Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eDeqaFyUH+t373rLitrTZEIIaPUpbaRV0kHjAm9kjE=;
 b=BmMllYT/PJi5942q+qWFgJviAiGRcFZlOGG/Fg+Xi2wT0lHYs8lYarXe2WCML6qVd63OpzHd3hpUWufmFyxK+pmtopxUrvgT6fksD53FbJjMA4m+6CnZpXGdvSnkn8pCqPUO79FthlD64bBnc4RyEAUwydbeTYcXDcxq9dHNJQExwO2XafchK7HkFWO3Utt5s17olLjQ4ryrhC4lxGAEpCMvZ5/sx62Aw9JY8RjsRoTAQBMa7uwQkA7z81rtDrzRVQGo8vmnF4Mz1jgYz8XDMOfhhm+yPnoy12Nq47b6mUd81Kh+Exc5ACE6+9De26fc3p1MBicyzCBDMoiV6nY+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=illinois.edu;
Received: from DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) by
 DM5PR1101MB2185.namprd11.prod.outlook.com (2603:10b6:4:4f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Thu, 24 Sep 2020 19:48:53 +0000
Received: from DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::c0ad:426c:3acd:3913]) by DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::c0ad:426c:3acd:3913%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 19:48:53 +0000
X-Gm-Message-State: AOAM532+gsBwskfeU7ofQ7qOKnV981Yczo34XEwOVfMVAi/O6IFM08Qe
        IDVpGHS0PRvUsGhQCKsu5F1T9+VX/XFnmNQsXa0=
X-Google-Smtp-Source: ABdhPJyj+Sk/ztigsJ/n9fAvmUST2Rwf4QsW6kca8GDDYtzy07Ixu5L7nWXa2hpO9pt1Tw2ZB25QgUpKG7lcMyu4pPE=
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr312371wmj.30.1600976929010;
 Thu, 24 Sep 2020 12:48:49 -0700 (PDT)
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200924185702.GA9225@redhat.com> <9dbe8e3bbdad43a1872202ff38c34ca2@DM5PR11MB1692.namprd11.prod.outlook.com>
In-Reply-To: <9dbe8e3bbdad43a1872202ff38c34ca2@DM5PR11MB1692.namprd11.prod.outlook.com>
From:   Tianyin Xu <tyxu@illinois.edu>
Date:   Thu, 24 Sep 2020 14:48:37 -0500
X-Gmail-Original-Message-ID: <CAGMVDEEtNXWp4xOhC+EMa_Z_1KMQhKQohCKVY=Z70wTuLr5X+g@mail.gmail.com>
Message-ID: <CAGMVDEEtNXWp4xOhC+EMa_Z_1KMQhKQohCKVY=Z70wTuLr5X+g@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Jann Horn <jannh@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Zhu, YiFei" <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        "Chen, Jianyan" <jianyan2@illinois.edu>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: AM0P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::26) To DM5PR11MB1692.namprd11.prod.outlook.com
 (2603:10b6:3:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-wm1-f50.google.com (209.85.128.50) by AM0P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 19:48:52 +0000
Received: by mail-wm1-f50.google.com with SMTP id k18so356230wmj.5;        Thu, 24 Sep 2020 12:48:52 -0700 (PDT)
X-Gm-Message-State: AOAM532+gsBwskfeU7ofQ7qOKnV981Yczo34XEwOVfMVAi/O6IFM08Qe
        IDVpGHS0PRvUsGhQCKsu5F1T9+VX/XFnmNQsXa0=
X-Google-Smtp-Source: ABdhPJyj+Sk/ztigsJ/n9fAvmUST2Rwf4QsW6kca8GDDYtzy07Ixu5L7nWXa2hpO9pt1Tw2ZB25QgUpKG7lcMyu4pPE=
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr312371wmj.30.1600976929010;
 Thu, 24 Sep 2020 12:48:49 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGMVDEEtNXWp4xOhC+EMa_Z_1KMQhKQohCKVY=Z70wTuLr5X+g@mail.gmail.com>
X-Originating-IP: [209.85.128.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5f134f5-6a88-4ee2-5d33-08d860c2dd68
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2185:
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2185219CC78BF3D85FCB8B9EBB390@DM5PR1101MB2185.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4/roYsX17cJquvZAgNYM4mKjXxywrCaPHnqd9CTwwTYHnBNHARkTQ2eCsQqfGv0h8vDhL77U8iTkOH1LQAMrbcVj9Nu/v/gzCSi5H+uUL57zSnUZSMu6YDuHSZd1biZpzLfa7etYsrl6WxF5f3edapBuHvUs1p7VYVSzuXSPmk5GD13phtL5GGOGbK3vww09ruijcNoM23l5wNX1FuCTnBn+63p8FMZoCN6/qoiuR96AP4YH/rSs/EEvfjNuWtgILohlSFRsTiKtqepOtvhMg4jidmqOKjk7wUkEywJX2RX7+5+JF9wPRCOZ0CWtGT0251nyc6KpqU/wYPbJ9UOw7mktt/VRT99SXjgGy1mtHcctfgu05OBQ+QdcuzdsMw6GmT2dXnWZLQt1H/9J5cSsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(55446002)(86362001)(52116002)(786003)(478600001)(2906002)(54906003)(450100002)(6666004)(53546011)(42186006)(186003)(6862004)(26005)(66946007)(83380400001)(8676002)(4326008)(66476007)(5660300002)(316002)(66556008)(9686003)(8936002)(83080400001)(75432002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iYsYykG5+Dle0ND1/sU3gu+HJTOyM5foAO6ffyrR0cioequfkIkGvUBNNb095jx17JprqTKet10qzLF48pf/bksco2txPwWXCQNkOP0ivAM1yQmrmF7lymAY3ySgNScgU+iVhLIksR7mHj2d5ncdwv6y90O4dDGCw5wcHv95j4sL24fH9xsmNOQ/hRPOPdoyEbSYv6cHMne2GwgXw3qmr5GHL0fMWMqegNcsrTk+l8mp0bL5Ag7jYuflBmXt6NUo8U/IoVL8zNBtAc+cWcTJI5tz4n+v7iJ3aAaXeKEGS4CLRKBHx6bDt6G7++izeBrZtGagO2TBukjXiT28a61B4sGfsGEw6VGMRoec5u84sDLm8D2hmzZTWXTez+PiP8ImXKxbaBtCCMSaG5Uk+3BNcVhZQSkuIJLgp1psVbS6/E794JhPahAjHNEZCWtTvY+LLodwL3S87qqp773w/EcokEggLj8JRjhV1a0Ua4L6OgLpUe2iyGYwdPL5LR2CLXrGf8D9nHVMEVZNOVJG25IYw3SijtvFLgSrrwGs8PozJVjF5uVsLRGfIFenNXqXWkEr4B2PfSBmqW9O5x/y1F2oBPOMdIRTGREQDlpK14MCV9cpqGLImnMtrvyKflozsr/whlTVyGn8GHEIhYLwho18OQ==
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f134f5-6a88-4ee2-5d33-08d860c2dd68
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:48:53.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K53g63T+1GZZhH5+iG9sJxdSZxWkJBDBnLuTfKUYA+QPqXovW3UokamR/GeOOvzgcljmrb21mi0dk+kA7NhFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2185
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1011
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009240143
X-Spam-Score: 0
X-Spam-OrigSender: tyxu@illinois.edu
X-Spam-Bar: 
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 2:19 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Sep 24, 2020 at 8:57 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > Hello,
> >
> > I'm posting this only for the record, feel free to ignore.
> >
> > On Wed, Sep 23, 2020 at 04:29:17PM -0700, Kees Cook wrote:
> > > rfc: https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
> > > alternative: https://lore.kernel.org/containers/cover.1600661418.git.yifeifz2@illinois.edu/
> > > v1:
> > > - rebase to for-next/seccomp
> > > - finish X86_X32 support for both pinning and bitmaps
> >
> > It's pretty clear the O(1) seccomp filter bitmap was first was
> > proposed by your RFC in June (albeit it was located in the wrong place
> > and is still in the wrong place in v1).
> >
> > > - replace TLB magic with Jann's emulator
> >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > That's a pretty fundamental change in v1 compared to your the
> > non-competing TLB magic technique you used in the RFC last June.
> >
> > The bitmap isn't the clever part of the patch, the bitmap can be
> > reviewed in seconds, the difficult part to implement and to review is
> > how you fill the bitmap and in that respect there's absolutely nothing
> > in common in between the "rfc:" and the "alternative" link.
> >
> > In June your bitmap-filling engine was this:
> >
> > https://lore.kernel.org/lkml/20200616074934.1600036-5-keescook@chromium.org/
> >
> > Then on Sep 21 YiFei Zhu posted his new innovative BPF emulation
> > innovation that obsoleted your TLB magic of June:
> >
> > https://lists.linuxfoundation.org/pipermail/containers/2020-September/042153.html
> >
> > And on Sep 23 instead of collaborating and helping YiFei Zhu to
> > improve his BPF emulator, you posted the same technique that looks
> > remarkably similar without giving YiFei Zhu any attribution and you
> > instead attribute the whole idea to Jann Horn:
> >
> > https://lkml.kernel.org/r/20200923232923.3142503-5-keescook@chromium.org
>
> You're missing that I did suggest the BPF emulation approach (with
> code very similar to Kees' current code) back in June:
> https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/

I don't see it's a bad thing that two (or three?) teams come up with
the same ideas,
and I'm actually happy that the final solution is largely converging,
thanks to all the discussions so far.

It's better to collaborate and help each other, instead of racing on
two separate patches,
and everyone involved should be acknowledged.

Not sure if it matters, we actually started working on seccomp cache
in the end of 2018,
and our idea is to also support arguments in the cache.
We still have the paper draft sent to an academic conference at Apr 2019 :)
Unfortunately, our paper kept being rejected until recently.
Sadly, as academics, we prioritized papers over upstream.

I'm disclosing these not to dismiss anyone's innovations and hardwork.
I do really think we should work together to merge the right pieces of code,
instead of competing or ignoring others' effort.

--
Tianyin Xu
University of Illinois at Urbana-Champaign
https://tianyin.github.io/
