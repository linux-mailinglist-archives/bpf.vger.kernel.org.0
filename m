Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51E53CAD8C
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbhGOUGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbhGOUGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 16:06:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A055C0770F7
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 12:59:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d12so7624535pgd.9
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=N+V3PJATaNKBqlyNmB101Aro1EeOj4LepVFaPzNpQxo=;
        b=uF1nGeq71hqj8e9PYDNYQIBUHBm8LaBu7Tdig5GekF0acc8wLaf52h103ZfDszxOpN
         vXegGgOTTWCu7Ag+83SNk98KStH9BBNbPbopjaTRHJufrGEZrpTkR+6jRmTPjg7AVi4M
         xfUZjs/9+ZF+jfsmKvIom8+T9cOnkKLLnLPW07B/qMF1033buK0PmATNFH1A917wk/O7
         yfNQ/nCZW0Gii8k2zX6s/f1Ce1afIbxrsGZsy8UbtrgdnpTFlkuz7p/bdwtWg4sfQiwA
         FUSCB/CgzNqCxMxYvy4QBzbCbDt2sFgoOHZRXSq52/K0vp6HQz8j/EXbt6WQ+bDaYBP/
         cI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=N+V3PJATaNKBqlyNmB101Aro1EeOj4LepVFaPzNpQxo=;
        b=EImUcTMO3Wi8ui/RXzTVUhYnWjgTu2Q6pSwOSDrJPWLuyWpp9g0+8Ps5RoMnu9l1XJ
         C6/y9yD9Vy2+uWnbu+E8pEBjdcIcwF4w6XRT/au0Q8GuqsWQKLlnfrLTZGi5DpTl46wu
         fqQODW7FZW+ek18Fw4/0BquD2pM3wQYVrU7DAUrtNb4Dal6LDDLa/ZvWFo3/nYgO28XX
         LdTdcl+1qPPkGojXbAcTTMrdDmOUE4ybETQJ1GVRDJMu00+I1O2s8dx+FoJ6+BT3ZWdW
         OS9UHiEj6zEMjgwaV/ZFdxDAWhEUSTXZd5JZcZrc+B61j3YdpmZDJm4WOOHPmasi577M
         +obQ==
X-Gm-Message-State: AOAM5336N9eS7d8Ulw00AqyQe1ZZK4FvoD+xg3a8H9C1v7w/v+Ck0lQc
        8PLRjYzvEWnhjuoHuazDdgrC6ul6P4xTIA==
X-Google-Smtp-Source: ABdhPJynh1pSWOyLEkGrLVkO2iNkpuXLgAnDhZ766GvjhRO0WwC9+JwR1yKHT/nC5E/3h8d7PCKWKA==
X-Received: by 2002:a62:7cc7:0:b029:32a:5351:8bf4 with SMTP id x190-20020a627cc70000b029032a53518bf4mr6114095pfc.69.1626379151542;
        Thu, 15 Jul 2021 12:59:11 -0700 (PDT)
Received: from localhost ([66.154.148.31])
        by smtp.gmail.com with ESMTPSA id o1sm6103713pjf.56.2021.07.15.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 12:59:11 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:59:10 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martynas Pumputis <m@lambda.lt>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Message-ID: <60f0938e8e7f6_7a66920818@john-XPS-13-9370.notmuch>
In-Reply-To: <f3aff467-7dbb-5aed-d3f8-32af62bcc53f@lambda.lt>
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-2-m@lambda.lt>
 <60ef818f81c18_5a0c120898@john-XPS-13-9370.notmuch>
 <f3aff467-7dbb-5aed-d3f8-32af62bcc53f@lambda.lt>
Subject: Re: [PATCH bpf 1/2] libbpf: fix removal of inner map in
 bpf_object__create_map
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas Pumputis wrote:
> 
> 
> On 7/15/21 2:30 AM, John Fastabend wrote:
> > Martynas Pumputis wrote:
> >> If creating an outer map of a BTF-defined map-in-map fails (via
> >> bpf_object__create_map()), then the previously created its inner map
> >> won't be destroyed.
> >>
> >> Fix this by ensuring that the destroy routines are not bypassed in the
> >> case of a failure.
> >>
> >> Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
> >> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 6f5e2757bb3c..1a840e81ea0a 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
> >>   {
> >>   	struct bpf_create_map_attr create_attr;
> >>   	struct bpf_map_def *def = &map->def;
> >> +	int ret = 0;
> >>   
> >>   	memset(&create_attr, 0, sizeof(create_attr));
> >>   
> >> @@ -4561,7 +4562,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
> >>   	}
> >>   
> >>   	if (map->fd < 0)
> >> -		return -errno;
> >> +		ret = -errno;
> >>   
> > 
> > I'm trying to track this down, not being overly familiar with this bit of
> > code.
> > 
> > We entered bpf_object__create_map with map->inner_map potentially set and
> > then here we are going to zfree(&map->inner_map). I'm trying to track
> > down if this is problematic, I guess not? But seems like we could
> > also free a map here that we didn't create from this call in the above
> > logic.
> > 
> 
> Keep in mind that we free the inner map anyway if the creation of the 
> outer map was successful. Also, we don't try to recreate the map if any 
> of the steps has failed. So I think it should not be problematic.

Maybe not problematic, but I'm still missing a bit of detail here.
We create an inner map then immediately destroy it? I'll need to
reread to understand the why part.

> 
> 
> >>   	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
> > 
> >          if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
> >                  if (obj->gen_loader)
> >                          map->inner_map->fd = -1;
> >                  bpf_map__destroy(map->inner_map);
> >                  zfree(&map->inner_map);
> >          }
> > 
> > 
> > Also not sure here, sorry didn't have time to follow too thoroughly
> > will check again later. But, the 'map->inner_map->fd = -1' is going to
> > cause bpf_map__destroy to bypass the close(fd) as I understand it.
> > So are we leaking an fd if the inner_map->fd is coming from above
> > create? Or maybe never happens because obj->gen_loader is NULL?
> 
> I think in the case of obj->gen_loader, we don't need to close the FD of 
> any map, as the creation of maps will happen at a later stage in the 
> kernel: 
> https://lore.kernel.org/bpf/20210514003623.28033-15-alexei.starovoitov@gmail.com/.

+1

> 
> > 
> > Thanks!
> > 
> > 
