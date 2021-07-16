Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160283CB0F4
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 05:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhGPDJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 23:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 23:09:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5659DC06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 20:07:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z1so7009004ils.0
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 20:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=affTBdVvHhRvH0PK4JupKzptMbybDU+2HLPFhYq6A5c=;
        b=azZmGQ52St9JRkT3q5y6pjXmJv3dCuikli/3AHyR6hihSrZA2cku36mOmTse+rz91b
         HTSyjUwqrvmpnT5SNNF74M9uKpdyZLmKFJdXbjEdlFzgybmWF7Lksfr305jzbq1PoZeU
         MfoBvBx94fqNu7aUwA9EnaH4fJPzVWXlbIocRgKe5pKod6Q+W5RK3vuDBVLTRmZDF5X3
         03haw6KgTe/OyIfXaMjb78hmI14PMuabsx93dfskD3/RJimHMfd5ECpGcMYed50TWODS
         dSNRjNZ4CHzIaTy4IQ4dqKWc55N3MiqzMnf/SMY8Ek5K3ZKArRLdHPkzp88ff3fsbnWC
         1cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=affTBdVvHhRvH0PK4JupKzptMbybDU+2HLPFhYq6A5c=;
        b=eeOWqVzSqAkMsyP3WklvifFEghe9MoRnaEnzrl1JJPZYfGdZ/lwMvdz7JiIfp/mvoq
         OklUuhIoV8kcrOxIaAW5Jh84R5beauMBsHrODSkuZ8pM2NYIzo3O9Wz5JYl+VaooeD9P
         4skgEaefKINZGkHh53JLIyDkpI0DxMoJesMlD1yfZaizULO+7jIfAiDcPuatPlUoaw8P
         FjRX8QOJGgBlqsKFanqxuHul5Zrqwsrrn/WM61N1UA/CzrcJLXb1GyFWhbdHnmjhWFOK
         IkaXqqJkzjrjkWRADvekV7LaKUVZB1nq51OS7F24lQ5S6j7DLZ/N03QbHOa8CEzGFqnJ
         nd0g==
X-Gm-Message-State: AOAM530EN5CQ7DXoDzfFFaoGiWsSTiu5kTFrvSu/xy+4nu6oGZUKcU4G
        kYQmPIwRwp8Qlyurj1HNQdA=
X-Google-Smtp-Source: ABdhPJyKaDwhpjkUXOp4M6SioZDY+eqHM1KDICCue/Rt3Ap8aG6Q0O+inXs4hS9gRPuStWdhkd7paw==
X-Received: by 2002:a05:6e02:12e1:: with SMTP id l1mr4861593iln.0.1626404822877;
        Thu, 15 Jul 2021 20:07:02 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id 15sm4240608ilt.66.2021.07.15.20.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:07:02 -0700 (PDT)
Date:   Thu, 15 Jul 2021 20:06:54 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Martynas Pumputis <m@lambda.lt>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Message-ID: <60f0f7ceb5382_2a57208ed@john-XPS-13-9370.notmuch>
In-Reply-To: <60f0938e8e7f6_7a66920818@john-XPS-13-9370.notmuch>
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-2-m@lambda.lt>
 <60ef818f81c18_5a0c120898@john-XPS-13-9370.notmuch>
 <f3aff467-7dbb-5aed-d3f8-32af62bcc53f@lambda.lt>
 <60f0938e8e7f6_7a66920818@john-XPS-13-9370.notmuch>
Subject: Re: [PATCH bpf 1/2] libbpf: fix removal of inner map in
 bpf_object__create_map
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend wrote:
> Martynas Pumputis wrote:
> > 
> > 
> > On 7/15/21 2:30 AM, John Fastabend wrote:
> > > Martynas Pumputis wrote:
> > >> If creating an outer map of a BTF-defined map-in-map fails (via
> > >> bpf_object__create_map()), then the previously created its inner map
> > >> won't be destroyed.
> > >>
> > >> Fix this by ensuring that the destroy routines are not bypassed in the
> > >> case of a failure.
> > >>
> > >> Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
> > >> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > >> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> > >> ---
> > >>   tools/lib/bpf/libbpf.c | 5 +++--
> > >>   1 file changed, 3 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > >> index 6f5e2757bb3c..1a840e81ea0a 100644
> > >> --- a/tools/lib/bpf/libbpf.c
> > >> +++ b/tools/lib/bpf/libbpf.c
> > >> @@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
> > >>   {
> > >>   	struct bpf_create_map_attr create_attr;
> > >>   	struct bpf_map_def *def = &map->def;
> > >> +	int ret = 0;
> > >>   
> > >>   	memset(&create_attr, 0, sizeof(create_attr));
> > >>   
> > >> @@ -4561,7 +4562,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
> > >>   	}
> > >>   
> > >>   	if (map->fd < 0)
> > >> -		return -errno;
> > >> +		ret = -errno;
> > >>   
> > > 
> > > I'm trying to track this down, not being overly familiar with this bit of
> > > code.
> > > 
> > > We entered bpf_object__create_map with map->inner_map potentially set and
> > > then here we are going to zfree(&map->inner_map). I'm trying to track
> > > down if this is problematic, I guess not? But seems like we could
> > > also free a map here that we didn't create from this call in the above
> > > logic.
> > > 
> > 
> > Keep in mind that we free the inner map anyway if the creation of the 
> > outer map was successful. Also, we don't try to recreate the map if any 
> > of the steps has failed. So I think it should not be problematic.
> 
> Maybe not problematic, but I'm still missing a bit of detail here.
> We create an inner map then immediately destroy it? I'll need to
> reread to understand the why part.

OK understand now ;)
