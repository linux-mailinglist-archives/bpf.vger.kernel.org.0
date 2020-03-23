Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D8318FE41
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgCWT4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:56:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44269 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWT4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 15:56:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id j4so16688880qkc.11;
        Mon, 23 Mar 2020 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7igelSqnZSzby+9Agw+dKmcrgK2R8ajZWmZKikiDho=;
        b=ZyQUyKFaEKEmFfsZZGGcpVLCY0rdoDcXD4zCVsS+DgCffo3uQdBYftPv9A3/cFjzvg
         JFKdIy5CKVRWPXrx59DJhXtz7S+IpYdEtq5rSdV8YO+GxrEDHDrjBXxjLWCV9k6HB15/
         VNZYAgWnrLlcKLCTxwkco4cJvfXlv9tytCQJnd7l3sWGPcsgnyDf6OLck2xJtnU7Z9pp
         tPg+oJAwbEXvTBeWkKUfNu4LDfcvPJVOlsrN6wkrNsqly5Ajl6cpgp/R62a5m3bp7BlG
         /Eiu4kdXD6AYVl550u98b798SiNPPtnMetTIrLGAIcMDJRRatccFCKoVSe37lckkmXbl
         bjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7igelSqnZSzby+9Agw+dKmcrgK2R8ajZWmZKikiDho=;
        b=cMW7yionHRpEQNC3o9xeE5nPUqOs6OaWtQTdRei8DzzkQxnGU5LX/5rUchpnEXsRvh
         9toGf05LyGOPFq9KnHyKZybncFMTt2tvHayKlhWtiP+yUrzP3sFJaaQpLSIcacqmp8BT
         4b6AuLs3Fh6fa/iVkqr12wHbTh48VFlGSoNIBTWqkV4GFWY7oWfYRT2PbkoynkYv/qFn
         nXfqp1lkQbKpnqNl3NiWYnG2oTWdUVdGsYLVR8Us76uVQRqKNE2QgMDV+uGQK79zWXJH
         TMeNZQmSe2JWpjxpnb1mQEbpjKhY8CA3VHnyPNaJ0me5VGYVG2xIDBGfTrHnz2dbqMw7
         vQNw==
X-Gm-Message-State: ANhLgQ0OWJhhAr4OxVRvw/7gFkeO41zJE4Wzf/uEA+4oqkb6DPBG3shz
        nwTPhWzaq8wuxYP357/Cmym0gQJ6+pVBt2VQ8HI=
X-Google-Smtp-Source: ADFU+vuNk+XojfkD2ANEtHWgonqRE45FobN+3bk7jLbXRujpqxIfFOz+ZhAN35zK9Cfgh1TYjbwqXMhx7RXBO8eHaQs=
X-Received: by 2002:a37:992:: with SMTP id 140mr23091475qkj.36.1584993408656;
 Mon, 23 Mar 2020 12:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-3-kpsingh@chromium.org>
In-Reply-To: <20200323164415.12943-3-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Mar 2020 12:56:37 -0700
Message-ID: <CAEf4Bza67kM0KiX464yB+iV83aV96TyD7iLEZJccXyH-Od0QTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] security: Refactor declaration of LSM hooks
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The information about the different types of LSM hooks is scattered
> in two locations i.e. union security_list_options and
> struct security_hook_heads. Rather than duplicating this information
> even further for BPF_PROG_TYPE_LSM, define all the hooks with the
> LSM_HOOK macro in lsm_hook_names.h which is then used to generate all
> the data structures required by the LSM framework.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  include/linux/lsm_hook_names.h | 354 +++++++++++++++++++
>  include/linux/lsm_hooks.h      | 622 +--------------------------------
>  2 files changed, 360 insertions(+), 616 deletions(-)
>  create mode 100644 include/linux/lsm_hook_names.h
>
> diff --git a/include/linux/lsm_hook_names.h b/include/linux/lsm_hook_names.h
> new file mode 100644
> index 000000000000..412e4ca24c9b
> --- /dev/null
> +++ b/include/linux/lsm_hook_names.h

It's not really just hook names, it's full hook definitions, no? So
lsm_hook_defs.h seems a bit more appropriate. Just for consideration,
not that I care that strongly :)


[...]
