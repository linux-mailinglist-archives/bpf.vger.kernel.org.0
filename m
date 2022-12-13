Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2813864AEB5
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 05:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiLMEnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 23:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiLMEnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 23:43:11 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9035CA1A8
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 20:43:09 -0800 (PST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD4PEqX032313;
        Tue, 13 Dec 2022 04:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=S1; bh=lvofQ6sbersYegSRRygu5ajOWlifKXARhaSS3B1Onck=;
 b=CtXllQSBuIFk3vphTgWoXLEyZcj8+w+BbnqB3yvBnxKfkj51Wt7dDme0zNzVPJsXamJr
 etVDXsecxHF6U+eRjpo10Y/xlGipbwL38eN6SjdLLnugXIF59SHbLOqsB4jFkkyDOZsk
 t3ZAa7jpWJAwWmwdCBhPB6m9KcM1Cc4YTDdF5CyqG16ZisPn1IJIkwAWQyMkLXvurOYU
 lSWOldK6ZO84DAnvdiXlX8pa91HimGpF5w0LlJ8IW2+szfdpMQDAWZcjxxZcx3Ssgvzo
 LlpPyQLiaSLB+KhdmYkPYmym74zgNO0EZFbtckBur78z1YE3rx2nQ/n/3qxouBQez2Xa Tg== 
Received: from usculxsnt01v.am.sony.com ([160.33.194.232])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcf962qr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Dec 2022 04:43:05 +0000
Received: from pps.filterd (USCULXSNT01v.am.sony.com [127.0.0.1])
        by USCULXSNT01v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 2BD4c6pB030453;
        Tue, 13 Dec 2022 04:43:03 GMT
Received: from usculxsnt11v.am.sony.com ([146.215.230.185])
        by USCULXSNT01v.am.sony.com (PPS) with ESMTPS id 3mchcg013r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 04:43:03 +0000
Received: from pps.filterd (USCULXSNT11v.am.sony.com [127.0.0.1])
        by USCULXSNT11v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 2BD4gs6a010879;
        Tue, 13 Dec 2022 04:43:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by USCULXSNT11v.am.sony.com (PPS) with ESMTPS id 3mchcgbt1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Dec 2022 04:43:03 +0000
Received: from USCULXSNT11v.am.sony.com (USCULXSNT11v.am.sony.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BD4h3l2010988;
        Tue, 13 Dec 2022 04:43:03 GMT
Received: from prime ([10.10.10.214])
        by USCULXSNT11v.am.sony.com (PPS) with ESMTP id 3mchcgbt1t-1;
        Tue, 13 Dec 2022 04:43:02 +0000
Date:   Tue, 13 Dec 2022 10:12:53 +0530
From:   Chethan Suresh <chethan.suresh@sony.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     quentin@isovalent.com, bpf@vger.kernel.org, Kenta.Tada@sony.com
Subject: Re: [PATCH bpf-next] bpftool: fix output for skipping kernel config
 check
Message-ID: <20221213044252.GA32424@43.88.80.127>
References: <20221206043501.5249-1-chethan.suresh@sony.com>
 <CAEf4BzbuRywbSsTn1gjvJ-c5JtTn+xTTA8ApS0B-aLyLXFJZrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbuRywbSsTn1gjvJ-c5JtTn+xTTA8ApS0B-aLyLXFJZrw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Sony-BusinessRelay-GUID: DiwwUecwX-zoKdSeGo_AmMpAKfYKxISf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_01,2022-12-12_02,2022-06-22_01
X-Sony-EdgeRelay-GUID: XWmWoUHeC_ieZIFJxEvN6SnzDL_wpxki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_08,2022-12-12_02,2022-06-22_01
X-Proofpoint-ORIG-GUID: z6cjk9KWc8km-BoSHElyp6R6n7qC14J5
X-Proofpoint-GUID: z6cjk9KWc8km-BoSHElyp6R6n7qC14J5
X-Sony-Outbound-GUID: z6cjk9KWc8km-BoSHElyp6R6n7qC14J5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_01,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 08, 2022 at 03:32:33PM -0800, Andrii Nakryiko wrote:
> On Mon, Dec 5, 2022 at 8:41 PM Chethan Suresh <chethan.suresh@sony.com> wrote:
> >
> > When bpftool feature does not find kernel config files
> > under default path, do not output CONFIG_XYZ is not set.
> > Skip kernel config check and continue.
> >
> > Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
> > Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> > ---
> >  tools/bpf/bpftool/feature.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> > index 36cf0f1517c9..316c4a01bdb7 100644
> > --- a/tools/bpf/bpftool/feature.c
> > +++ b/tools/bpf/bpftool/feature.c
> > @@ -487,14 +487,14 @@ static void probe_kernel_image_config(const char *define_prefix)
> >         }
> >
> >  end_parse:
> > -       if (file)
> > +       if (file) {
> 
> There are two error conditions when file != NULL but we actually don't
> read kconfig contents. Please handle those properly, otherwise all the
> same confusion will keep happening.
As I understand, the check should skip when file != NULL itself rather
than handling it in end_parse.
I'll send the updated patch based on review.
> 
> >                 gzclose(file);
> > -
> > -       for (i = 0; i < ARRAY_SIZE(options); i++) {
> > -               if (define_prefix && !options[i].macro_dump)
> > -                       continue;
> > -               print_kernel_option(options[i].name, values[i], define_prefix);
> > -               free(values[i]);
> > +               for (i = 0; i < ARRAY_SIZE(options); i++) {
> > +                       if (define_prefix && !options[i].macro_dump)
> > +                               continue;
> > +                       print_kernel_option(options[i].name, values[i], define_prefix);
> > +                       free(values[i]);
> > +               }
> >         }
> >  }
> >
> > --
> > 2.17.1
> >

