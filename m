Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9142159E
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 19:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhJDR42 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 13:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233881AbhJDR41 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 Oct 2021 13:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633370077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+2zA1jjle3vmfTB5/pcGcT1V4t7upA8muF5rWRjTyI=;
        b=eUkiB07ZvRupaWjs0f7E0MOZqieYpDjHmYyRh8BWnkJIuICHHs5L4LqgPiduoV6S76QAQ1
        FA9xOrUdADgLL7YqNML5W2vyqgZgjj/ytnQlCSKrCkT8ikJl1JkHh/7KAveecxMGWKwowd
        engCwdmnfcSpM1thDk2dy4I87dvmQx4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-RGnTP0r-OsiCcyMtHN039A-1; Mon, 04 Oct 2021 13:54:36 -0400
X-MC-Unique: RGnTP0r-OsiCcyMtHN039A-1
Received: by mail-qk1-f199.google.com with SMTP id t2-20020a05620a450200b0045e34e4f9c7so24603320qkp.18
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 10:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y+2zA1jjle3vmfTB5/pcGcT1V4t7upA8muF5rWRjTyI=;
        b=yTOCMZrIh1/8TrR+TrifMGSLaKDgbUKcPwtvTavzZDJ5JIoSzmKuIq8Q5Hd47Qd1wM
         XsxYFh4wwTEWjPHId6OtHizY55IiExYjW17DG0VHmR5px/sPejHvNdWl+mAk0d1NYQbH
         rXPctwo+B6OLpp5dZnmDsRwS5bgrsD1diBwhjz05OJAEM3lqfATg3snB/+P1QNEWfC1b
         negdHl0YEqI/81Ms5yb8EmRk7p7ZueYP2cv0vadZCb8xQTi0/HY7kZ3ivtFCaIRKymPY
         WRBrmFcYXrnb4Dv1GW6rDaCAfz69EOxvFnR2EL9djCArxV6W2M7180frg92kgdxZQcNg
         H08Q==
X-Gm-Message-State: AOAM531CX7/S9hKBaP0b1calx4R+iKbyb0h8u0oz7vX6uJdRnAonuaBd
        yA8czZ3uCnaADJbdNhJnN5UHvnRCkEFRfsGzKztu9whHTCA0s8ysdWDLjTrRziFvsGIL8AdrlZ5
        PQGAsWVVeq7LV
X-Received: by 2002:a05:622a:1646:: with SMTP id y6mr14823559qtj.146.1633370075981;
        Mon, 04 Oct 2021 10:54:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOn+3ShPF0raBL9KUr3smyATPofejRnGaUi0gpHiRJsdE8Mg50Kmary4N5R8LkG0fx0Rb1ew==
X-Received: by 2002:a05:622a:1646:: with SMTP id y6mr14823519qtj.146.1633370075730;
        Mon, 04 Oct 2021 10:54:35 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id g12sm9153881qtm.59.2021.10.04.10.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:54:35 -0700 (PDT)
Date:   Mon, 4 Oct 2021 10:54:31 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/1] x86: change default to
 spec_store_bypass_disable=prctl spectre_v2_user=prctl
Message-ID: <20211004175431.5myyh2wqnxbwqnwh@treble>
References: <202109111411.C3D58A18EC@keescook>
 <AAA2EF2C-293D-4D5B-BFA6-FF655105CD84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AAA2EF2C-293D-4D5B-BFA6-FF655105CD84@redhat.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 11, 2021 at 07:01:40PM -0700, Josh Poimboeuf wrote:
> 
> 
> > On Sep 11, 2021, at 2:13 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > ﻿On Wed, Nov 04, 2020 at 06:50:54PM -0500, Andrea Arcangeli wrote:
> >> Switch the kernel default of SSBD and STIBP to the ones with
> >> CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
> >> spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.
> > 
> > Hello x86 maintainers!
> > 
> > I'd really like to get this landed, so I'll take this via the
> > seccomp-tree unless someone else speaks up. This keeps falling off
> > the edge of my TODO list. :)
> 
> Thanks!  You can add my
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Hi Kees,

Ping - I don't see this patch in linux-next.  Are you planning on grabbing this
for the next merge window?

-- 
Josh

