Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770711792FF
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCDPLN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 10:11:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39631 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgCDPLN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 10:11:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so2830166wrn.6
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yT7XeoSwUdQk121SDMf3G5g+/PJMGsICwgeNmRY4RQs=;
        b=AwWGHCjdbOoLCZNfTjqCPibGkm2uREaDzZapM7b/n3n7Nwkrs1hqcGWlxuLlrw2muO
         1j29uSfwHFQVcOeMU9krUtHsG7P+kDz5jRFL8cWEYsyVC2DqWybq30o9KuKutALdHKfz
         LlPQoJFSTux9e0xsm51R7QkJlMMo5Zd6C6708=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yT7XeoSwUdQk121SDMf3G5g+/PJMGsICwgeNmRY4RQs=;
        b=DZVLFMQQMQZzn0lFdmVTgkX6+OS9R4bjx4uodbyveSRI1scRMpinkF8TjAhVHhHjPm
         NQ8CVa0S4g9Fzg6lekhNX+Fikz/Wdn1jNrt2Y+R4MS2jsPE3oBD+AF8GYfm2gqWMed4P
         dlOidXBZdb/fk4IZOFtSTwkLjgjC6jFfZMPs3fARnS5PJcVY3VKuFPOBtvI0E6FgiEd5
         8ba1rsUVtB7ODJN/ChfL2MNx7cT9bnSepmccQIG/pSQXsxhBJ++dUTMK9ona7n9gWu4m
         ZVW+BJHE2XGFw+BBEaZ2/x8BPyQSOSnPnsX17pTbIDZsfiuE0c7Nbwf+e95cY3ytux5+
         XGgA==
X-Gm-Message-State: ANhLgQ1Tw/gPqaof46cwI58tKdvT/3Em7JBAri0PSALdRXjXacx/HI/u
        LkYk4tgHGNo5Lz7nb+U0mVzqWg==
X-Google-Smtp-Source: ADFU+vto2Y4+7brCgQ56OnMcDSr46ZwMvvFzkph4qgpP4LS5CH2zpn81VmjOJ0tB9uRs5I9cRSNrVA==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr4555742wru.421.1583334669504;
        Wed, 04 Mar 2020 07:11:09 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id v8sm4971969wma.28.2020.03.04.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:11:08 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:11:07 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Refactor trampoline update code
Message-ID: <20200304151107.GA9984@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-2-kpsingh@chromium.org>
 <CAEf4BzZ58iymCdqqCe=p-7BSF_kt+Dd19taEjTJBEt_ZBZz0=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ58iymCdqqCe=p-7BSF_kt+Dd19taEjTJBEt_ZBZz0=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 20:49, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > As we need to introduce a third type of attachment for trampolines, the
> > flattened signature of arch_prepare_bpf_trampoline gets even more
> > complicated.
> >
> > Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> > use bpf_tramp_progs to simplify the addition and accounting for new
> > attachment types.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> See note about const-ification of trampoline and naming suggestion,
> but looks good overall:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> > +static struct bpf_tramp_progs *
> > +bpf_trampoline_update_progs(struct bpf_trampoline *tr, int *total)
> 
> reading the code again, seems like bpf_trampoline_update_progs is
> really more like bpf_trampoline_get_progs, no? It doesn't modify
> trampoline itself, so might as well mark tr as const pointer.

Makes sense. I will send a v3 with these some minor fixes by EOD ZRH.

- KP

> 
> 
> > +{
> > +       struct bpf_tramp_progs *tprogs;
> > +       struct bpf_prog **progs;
> > +       struct bpf_prog_aux *aux;
> > +       int kind;
> > +
> 
> [...]
