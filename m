Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0C14031C4
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 02:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhIHAGX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 20:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347250AbhIHAGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 20:06:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14177C061575
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 17:05:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e133so602793ybh.0
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXyawQMXxksoofwVVCGcqO34v7L3DdJebGbUWwoRVkk=;
        b=Zs37zvrAvEiSufijaD2sNa8wgxPo4lqaCDNGam5mGxIQGW/nWCLxyjw0wJzD03pTNf
         VhzuRYfZYI017pUuxw0rtH8qqG/gvUUeB9+Vp7fli0Dx0k4G2vbOR9kdDfh1YqIh78PI
         04tPtMUsY8zjJrp2WAsdfcIAtZow+7gD10TDKlfZF9PPumtC99CRLUu+F/J0FaRUJyy3
         JQP3TXFWG8+bQ37w/mMEZtmYN/XLflGrKkQ/Z7bCuEo/gKnj+SsvpJ9foR8iFS1iMdvi
         R8COryqKEB7BEIXcf3ubgquaa2QgAG6TixRPKsFY6eAPf+99x8t/pD1KXUZT2LqIwllt
         EQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXyawQMXxksoofwVVCGcqO34v7L3DdJebGbUWwoRVkk=;
        b=V6mgfb8DQp28AlBvAuwnTeYZ6FXi5Q6K4F+BNnJSXBsyX7hxGILwlfln+ypliJAGxT
         sIAj4pAZOndxwBm3YlmW6mXiQOmlR/fhzu6ITi79T3lFFQQYtRHXf6NAEwT5kMfTyjEH
         qqwhajOlnKdaRBfrvaCycfIPX2UyHdje4xh9bpYJ9Zv3Bv8g/sWlciN/xLZwtmVggCJ+
         HayBDSb45P2IydI/u6+z4s9aAANYm7knPGDN+j4vsv6/WiDPYsJwS35d0eCU3VmiUe5P
         nOhfWxQQbq0rb2dXVDt6aL911lhXrBAMb8Dnwq5ja7tUpV91KdwP+Njou4A+Le1KnHXu
         m2Cw==
X-Gm-Message-State: AOAM532BFBy77lTw7Ecu5yyR7sUyo78X0gtrWmabZWONYtG6PeEVziEz
        nx/+6jaErUf7Hc92pO9F1u2RNnlEREhYpRTCCY4=
X-Google-Smtp-Source: ABdhPJz4bDHls6SHOnXUUE08gJ60GYmnNX2ik/Ht8ZrHMmnNczzxEZ5/WHSG2Mni7OyzfX0z4LTieiex6vRvG03Le1k=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr1473932ybt.178.1631059502331;
 Tue, 07 Sep 2021 17:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210831033356.1459316-1-ntspring@fb.com> <612f161528808_152fe2084d@john-XPS-13-9370.notmuch>
In-Reply-To: <612f161528808_152fe2084d@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Sep 2021 17:04:51 -0700
Message-ID: <CAEf4Bza=-7FfG-EpuQhzJHShgpZ+VoH+eFWt6WOXAif4OEMeEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf testing: permit ingress_ifindex in bpf_prog_test_run_xattr
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Neil Spring <ntspring@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 10:56 PM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Neil Spring wrote:
> > bpf_prog_test_run_xattr takes a struct __sk_buff, but did not permit
> > that __skbuff to include an nonzero ingress_ifindex.
> >
> > This patch updates to allow ingress_ifindex, convert the __sk_buff field to
> > sk_buff (skb_iif) and back, and test that the value is present from
> > tested bpf.  The test sets an unlikely distinct value for ingress_ifindex
> > (11) from ifindex (1), but that seems in keeping with the rest of the
> > synthetic fields.
> >
> > Adding this support allows testing BPF that operates differently on
> > incoming and outgoing skbs by discriminating on this field.
> >
> > Signed-off-by: Neil Spring <ntspring@fb.com>
> > ---
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Applied to bpf-next, thanks.
