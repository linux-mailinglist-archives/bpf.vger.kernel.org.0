Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A368847A57
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2019 08:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFQG77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jun 2019 02:59:59 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40252 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFQG76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 02:59:58 -0400
Received: by mail-lj1-f177.google.com with SMTP id a21so8168919ljh.7
        for <bpf@vger.kernel.org>; Sun, 16 Jun 2019 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAPMTgUkH2BrAhmQzg83zHPUYP2IIv22+l1H3bxOk64=;
        b=sot51EAOYqVvCfAujb4x82YjnjcPXUhx/q+dKRW8v7qiwecTd/UTlTytLrsZIB/5vu
         6OJBHt8VfHZAoh5rUeJrOpDfi6G3qC5TmuQXkjK3T8DfVfv79VYlfyNb1DDvZTz+6EpC
         QU7Ku3QoMx3W7uzdpwZc+AdvZwvGdW5hYzzbe4fIZUHxSRda9UdSeYWIHPwX8RTGhBlN
         MKfBbQEDJfkn1ck7AjjOF28xKu+FBOiLggVdDXNza8AJTkp4uoI+zCOUBwnAI5Elwi+S
         ELjIpPrLHyi15WUjGBJD9NDuTvhfK3yCH62apzNims7SXuvX8oaoz464NWbEPXGntAyC
         KsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAPMTgUkH2BrAhmQzg83zHPUYP2IIv22+l1H3bxOk64=;
        b=jttZQWn+VzOGNMcvtqpiLFbqCpnx0U8aC8ydrX1KRjdUq9ZMRM8Cj4vvhioibycUQV
         PsQB9O6pyIocvpYLD3+ekkmn+wDYLsLUcZI0ETsPUqIPEuFnYGUk4Ag6R+bWY9JahPjr
         PIMLbmlIuNytrnjCHbGioWw3SPg2SMTgN4c6HVxZM39MPMwLiOOR2sIdyJP+JAHT5+S4
         ZMiQPrjogUWvCLSCQdeaNwaHs6ayaDLqYW+kqF/V0DanWiFQBPs+e6oJVATFb8GX+ABz
         1/gBAxmvPp1yDvtLR8pQ0r3B56Yfiks2ZZSB0KYr3Ou2jNOi9l8U2mIvrF8dE2AF7Njl
         53Rw==
X-Gm-Message-State: APjAAAU9MDZlr3gMpC3YK4TbK0BI0OJFSWb2f+aCYUGzxqQWnNS7KKwI
        /aEE7JAUF6yF6xEDu2OsqFkmc9Uimvi3/8cqGbs=
X-Google-Smtp-Source: APXvYqwBdnOTU9sv30pQ4K4kR7WWFqlaB1oWqTL+CGdX0ed5qXYxgOoo1TDNuNwHzNRuj+3R5v16DUsW0rlP55hpm9Q=
X-Received: by 2002:a2e:9ed6:: with SMTP id h22mr19650279ljk.29.1560754796744;
 Sun, 16 Jun 2019 23:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
 <CAADnVQLmrF579H6-TAdMK8wDM9eUz2rP3F6LmhkSW4yuVKJnPg@mail.gmail.com>
 <e9f7226d1066cb0e86b60ad3d84cf7908f12a1cc.camel@domdv.de> <CAADnVQKJr-=gZM2hAG-Zi3WA3oxSU_S6Nh54qG+z6Bi8m2e3PA@mail.gmail.com>
 <9917583f188315a5e6f961146c65b3d8371cc05e.camel@domdv.de>
In-Reply-To: <9917583f188315a5e6f961146c65b3d8371cc05e.camel@domdv.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 16 Jun 2019 23:59:44 -0700
Message-ID: <CAADnVQKe7RYNJXRQYuu4O_rL0YpAHe-ZrWPDL9gq_mRa6dkxMg@mail.gmail.com>
Subject: Re: eBPF verifier slowness, more than 2 cpu seconds for about 600 instructions
To:     Andreas Steinmetz <ast@domdv.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Edward Cree <ecree@solarflare.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 6, 2019 at 6:31 PM Andreas Steinmetz <ast@domdv.de> wrote:
>
> Below is the source in question. It may look a bit strange but I
> had to extract it from the project and preset parameters to fixed
> values.
> It takes from 2.8 to 4.5 seconds to load, depending on the processor.
> Just compile and run the code below.

Thanks for the report.
It's interesting one indeed.
600+ instructions consume
processed 280464 insns (limit 1000000) max_states_per_insn 15
total_states 87341 peak_states 580 mark_read 45

The verifier finds a lot of different ways to go through branches
in the program and majority of the states are not equivalent and
do not help pruning, so it's doing full brute force walk of all possible
combinations.
We need to figure out whether there is a way to make it smarter.
