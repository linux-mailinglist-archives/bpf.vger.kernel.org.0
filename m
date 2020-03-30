Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0219821A
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgC3RUh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 13:20:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44602 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3RUh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 13:20:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so8893056pfb.11
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GhMliyyhvKck+U/IM2gz1ldhvMRyO4M5LcMCOm4Fcy0=;
        b=UORjw8xfgovq6uZOnT5oQrv/4kgJygm8q3iAblXxyBR6Qv8Wn+QswDm4NENT7VQbBY
         M2e/Tuw6E1FkkIcr+v/rqhHIhVKYNHEDZSrPIub3oigQqVKxvUyPndXAN+5kT8/dEe5s
         wJ6L/IRue6LH78eQ/X2CimsyO4AU1SdKMxYS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GhMliyyhvKck+U/IM2gz1ldhvMRyO4M5LcMCOm4Fcy0=;
        b=MGtM+J58jKnd4jFwYFTlH9iyMYJjWy/7+0HMx25OIWdzbgOo6qBBvVFyvagI0A90Tj
         oAXpAiIqYDXyzv4xwPuKEh9CH4X9bXiHhViS0Ww5weq3Z1R7ZutDwui1OZAFOsI+Q1BH
         10npwd+iEyf6gnPtZFeJzElHiYoSb1GWfZlULwl08DmeXLFfurxwGYxiKDLc6g1PZL2C
         R80elVgi8PXBKhhZ02BYCiXdtIsIiEJLzvZGe6tzMZkoVAUGMj9y3TR7W2on9h9PWv0p
         3nJay6qO0VuoGtwUAeDLTvaUgw8WXEoquxmnKD7QHUjeCDLVj3R6q93CbHm9yx4uaz2r
         qtkw==
X-Gm-Message-State: AGi0PubOdAMmWR53GM65f+BxXCjMam/60WIaB3sa5STPTCVhxAsfaT7B
        s8lsBZqzgR92o05KD4jPckR3+Lg4Wxg=
X-Google-Smtp-Source: APiQypLO66Bncr70Jt+tX2A613FQoNLHRm/juUOpte4V1NJX6oWU5U3CzkLcAOMsbPvV/4fPHZb2NQ==
X-Received: by 2002:a63:e942:: with SMTP id q2mr166658pgj.34.1585588836058;
        Mon, 30 Mar 2020 10:20:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n29sm9935693pgf.33.2020.03.30.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:20:35 -0700 (PDT)
Date:   Mon, 30 Mar 2020 10:20:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
Message-ID: <202003301016.D0E239A0@keescook>
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 30, 2020 at 06:17:32PM +0200, Jann Horn wrote:
> On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
> > > of CONFIG_GCC_PLUGIN_RANDSTRUCT.
> >
> > Is it a theoretical stmt or you have data?
> > I think it's the other way around.
> > gcc-plugin breaks dwarf and breaks btf.
> > But I only looked at gcc patches without applying them.
> 
> Ah, interesting - I haven't actually tested it, I just assumed
> (perhaps incorrectly) that the GCC plugin would deal with DWARF info
> properly.

Yeah, GCC appears to create DWARF before the plugin does the
randomization[1], so it's not an exposure, but yes, struct randomization
is pretty completely incompatible with a bunch of things in the kernel
(by design). I'm happy to add negative "depends" in the Kconfig if it
helps clarify anything.

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84052

-- 
Kees Cook
