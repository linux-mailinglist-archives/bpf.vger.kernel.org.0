Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A301F2B44AC
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgKPNZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 08:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726615AbgKPNZn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 08:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605533141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LSNkJPt+wjH1jlYQkXrm8+t1fMHnnPEPcU8guCAdnmA=;
        b=aMMb2q7Jd1UKSFnmhbnVc4BM+Oz4EYindeY6imfb/s39GP388INwLHVgWNs3Ci6PlRwTyR
        cuI8sLfBEn1/PZbzS9oOiSLfeqkpaw6aZ3rfLNLF7xgQukpWtqRpWX7l85IT7hlgntvtFM
        7P0UDte3QS6J05bMWGRwqaNx0YHTcbw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-V9ruSk73NXWDKIKvE44F-A-1; Mon, 16 Nov 2020 08:25:40 -0500
X-MC-Unique: V9ruSk73NXWDKIKvE44F-A-1
Received: by mail-oi1-f198.google.com with SMTP id o130so8270957oig.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 05:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LSNkJPt+wjH1jlYQkXrm8+t1fMHnnPEPcU8guCAdnmA=;
        b=ngzD5GQLaFCv38mVh4VHDKHH4VLwwbxDM4L9pCW7YEjFFm/WN6YdPlgeGVlfEXFsn7
         ArkgWbHSem09rFLNYM8jh3kvoWCODNnARrdzZFrXe6EaiyVIMyF7GRgJxxibcnL11/Yc
         82Qc/8NVJ+r9grD5VIg439r50ZLM00upRKtY8NLujWBV48k25ycSLH5T8l+YxAHgXGl0
         3jyHGTymf1QJwkSx2B7T//hXCIZnypAClPu9DnO/LRI5fvOtwLw6FtunMbVt9lZPWww5
         9NcmnaXcoi3Jlfl9esh5zdONOHFP8f8AmnEaQd/BPeIic/JvtPfD5bbNTgrRu9nnb2U7
         +IYw==
X-Gm-Message-State: AOAM533q5sLM5aE79VWgKVcB6Ew2R6+TNjo/Lv+Adwcd8hJtetSUEP4Z
        avg56KIuJuutO5HQ23AybTz6/Thyez+/qZVlYtu4hZ5c5dia6gyk1IOrdHGx1VO9vSuyTil3y2U
        AfXzBgDJIAnAp
X-Received: by 2002:aca:aa90:: with SMTP id t138mr9995752oie.171.1605533139396;
        Mon, 16 Nov 2020 05:25:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrcA2prPU1Jbe9yJjkB8jL+sl2t2d8mCJs8iqH0rtGEAwN11et6kly+E4Ca4QR0EDC3hTQsQ==
X-Received: by 2002:aca:aa90:: with SMTP id t138mr9995708oie.171.1605533138652;
        Mon, 16 Nov 2020 05:25:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k11sm4636793otr.14.2020.11.16.05.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:25:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 05567181CF8; Mon, 16 Nov 2020 14:25:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     alardam@gmail.com, magnus.karlsson@intel.com,
        bjorn.topel@intel.com, andrii.nakryiko@gmail.com, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        davem@davemloft.net, john.fastabend@gmail.com, hawk@kernel.org
Cc:     maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        maciejromanfijalkowski@gmail.com, intel-wired-lan@lists.osuosl.org,
        Marek Majtyka <marekx.majtyka@intel.com>
Subject: Re: [PATCH 0/8] New netdev feature flags for XDP
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 16 Nov 2020 14:25:35 +0100
Message-ID: <875z655t80.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

alardam@gmail.com writes:

> From: Marek Majtyka <marekx.majtyka@intel.com>
>
> Implement support for checking if a netdev has native XDP and AF_XDP zero
> copy support. Previously, there was no way to do this other than to try
> to create an AF_XDP socket on the interface or load an XDP program and
> see if it worked. This commit changes this by extending existing
> netdev_features in the following way:
>  * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRECT})
>  * af-xdp-zc  - AF_XDP zero copy support
> NICs supporting these features are updated by turning the corresponding
> netdev feature flags on.

Thank you for working on this! The lack of a way to discover whether an
interface supports XDP is really annoying.

However, I don't think just having two separate netdev feature flags for
XDP and AF_XDP is going to cut it. Whatever mechanism we end up will
need to be able to express at least the following, in addition to your
two flags:

- Which return codes does it support (with DROP/PASS, TX and REDIRECT as
  separate options)?
- Does this interface be used as a target for XDP_REDIRECT
  (supported/supported but not enabled)?
- Does the interface support offloaded XDP?

That's already five or six more flags, and we can't rule out that we'll
need more; so I'm not sure if just defining feature bits for all of them
is a good idea.

In addition, we should be able to check this in a way so we can reject
XDP programs that use features that are not supported. E.g., program
uses REDIRECT return code (or helper), but the interface doesn't support
it? Reject at attach/load time! Or the user attempts to insert an
interface into a redirect map, but that interface doesn't implement
ndo_xdp_xmit()? Reject the insert! Etc.

That last bit can be added later, of course, but we need to make sure we
design the support in a way that it is possible to do so...

-Toke

