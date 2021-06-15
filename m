Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D583A78B6
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhFOIIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 04:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFOIIf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 04:08:35 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC68C061574
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 01:06:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id if15so11085768qvb.2
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9C1uS57Jvtyo1xduydMBOgtKHXJBGBj6X56dQGCOg2Q=;
        b=t8X5Uw5wtspiiVswHwXUb4KoIcg6PTgjSRRO8Pa+Hv1gDmHSBBjTelSlKEYOqW6IOh
         3rFQkYJi5TMzvnmA5GkHLfzIc9yB4hFZTJXSP3q7S8E/Qz94OpO2IYcG4Ie814pXioLu
         uV8LxiWpBBCFyb2nTYb5+ZwdoBNOQmspdgjM8VTgYTHtG/zVca+XDWptyFIxJjr/anRz
         o4k6WTI0GJbfw7KZtBzsLXrxf4a2P6vQsjjZqold7VQwyJmqO1EcAHx4oPa0TIrvqL4a
         e0ur+iKfUwnW7i8Lmb9qseo3JyP/ggwaiA9Jhe1myum67KaAnhP8j369HAeI0qCJEmak
         /4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9C1uS57Jvtyo1xduydMBOgtKHXJBGBj6X56dQGCOg2Q=;
        b=MGCzpCPmG3okIfj4x4kybUUas5GHLsrakzm90yjtKPt8VydC6vfg+8fhDxNNxjbRIA
         tnJrdP1cC7HTt139ZpoVeezINkJroE6rwojWOy2WTdKbEBisGlOIUMMfE1kDVKPwzQAO
         8Mu2zSi5R6bZXvrGZqaFpdQbSWXlwDtI2jaVqyu7wgkpYd5ps4/g1UY0TiGt1vX8AY3V
         l2hQgKem5cnUcjd5HBAX/Qrn6fl4Rs/LbNq3OMoRA0hlTqGegdzzLof8VVMBMeRz03l+
         crw+3Mi4tU05KO6SEqjpy1NnU1w2MGCRoTe938jeAKdPCZM0o2b9DOushXERPajqkYy8
         37Pg==
X-Gm-Message-State: AOAM530hzlNmNJ779sU1Zt/vbNgRpNmbwwfSiRBLPO0Xq8esxgWtmgEt
        uYe85z096TV/HuL0QKxdp81bw0ylYfstfDVyuGe2tpdSxJ08
X-Google-Smtp-Source: ABdhPJy7KXDLTMbjoQFJdBsop2uVZQgSGG9uhB31ao5lFYlGkp+Bc5W545J8Ea4cDVjyppLU9fa+ZJnuGbuVvaVbSiU=
X-Received: by 2002:a05:6214:1d28:: with SMTP id f8mr3919344qvd.32.1623744389832;
 Tue, 15 Jun 2021 01:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
In-Reply-To: <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
From:   Jussi Maki <joamaki@gmail.com>
Date:   Tue, 15 Jun 2021 10:06:18 +0200
Message-ID: <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "Geyslan G. Bem" <geyslan@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 8:28 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> It seems kind of silly to update our perfectly working image just
> because a new version of glibc was released. Is there any way for you
> to down-grade glibc or build it in some compatibility mode, etc?
> selftests don't really rely on any bleeding-edge features of glibc.

I've also hit this issue as Ubuntu 21.04 ships with glibc 2.33. I
ended up solving it the hard way by rebuilding the image (I needed few
other tools at the time anyway). Definitely agree it's a bit silly if
we'd need to bump the image every time there's a new glibc version out
there. I did try and see if there's a way to build against newer
glibc, but target older versions and I didn't find a way to do that.
Would statically linking test-progs be an option to avoid this kind of
breakage in the future?
