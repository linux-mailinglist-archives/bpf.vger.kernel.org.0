Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2098D1789E2
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 06:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgCDFNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 00:13:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41316 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDFNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 00:13:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id b5so430261qkh.8;
        Tue, 03 Mar 2020 21:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxfKMRYycoYJCMjo+bMFWJRwnGnU13AVvKUckPyxeSo=;
        b=K5Fn7w8SmnIBj8Lc9FZok49SJWB6g/q/Iga7hGwmiFt+PvrkBDKrKfNigTp77YxG9X
         DPuvoDPY+71aruC/wBH3cVGt1rRCaJEXKOLVpxMsDTPajmm72QvPDOWHNN8zLSHzdtuG
         KFoCJVbiTmToQ5WIewb6q7t96jAnIeGAcol4qQRWHd994e9P/bnG8+ryfXWaHqoMcBTO
         dMml4IRUX9PPz/kzdO5V5UgWu4+yMXt3B8I3WPmTxvJhNurnND1C9wqIdue+KZk564qh
         OzvlIfr4noAmNfAOCdekZQe6ygE8ZqthS2f8MWN1pKfkJ9S6bLCEZ8aozzFOImi6VKr2
         gk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxfKMRYycoYJCMjo+bMFWJRwnGnU13AVvKUckPyxeSo=;
        b=q5XfS03CdwdaB2aTikw8fhf7cSPbL4WijAv5cuPt8yoNtTcPNVMNSKscl2dSvbdc7D
         aV1+bioHBAAheDZkiZMpr2SiYyxtaFOGdXpNRvcEiQ+S82oGZLoIvEtnKmyovyG7XX15
         Rw0wXpdf+vYFlbg5uAGPj9Amk9eNV0VmM1hIxvq/lR8NoDcCsgV2pXSPYTWJyU7B7VPJ
         4Bg1RcVa6VWoCiw0iHDsBzYKlfXp/7gKzZyk0z+jJJxMT3uDS5H6tiapxLjY+8SjmCjn
         8U60+VEmye88sm0PdzWI0fu4Mu5ChVSOUNqMZjcPZ8fAM7Anwn22KKZZ55b7PGnspoI9
         FYJg==
X-Gm-Message-State: ANhLgQ3ZwlnfXDm1E756thEnsakdJg95MPextP80aiVImWFSc5aubxSs
        VWdNqvmsZuXK9N55vYWZxTQlCleeOb17Iz16C6Q=
X-Google-Smtp-Source: ADFU+vtzCLI06uGJU75QdLWpADbjaRR4sP9m7GAksEwL9DWlE1GZMxFgdM8Vtf8bZY4MVdtet9MF9YvtDv9Tkt89qoY=
X-Received: by 2002:a37:a70c:: with SMTP id q12mr1440438qke.36.1583298789150;
 Tue, 03 Mar 2020 21:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20200304015528.29661-1-kpsingh@chromium.org> <20200304015528.29661-5-kpsingh@chromium.org>
In-Reply-To: <20200304015528.29661-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 21:12:57 -0800
Message-ID: <CAEf4BzZdR-PTFZT5VJ7kMw=FNhsCUpbQvdypEWSF1JNuaye6Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/7] bpf: Attachment verification for BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> - Allow BPF_MODIFY_RETURN attachment only to functions that are:
>
>     * Whitelisted by for error injection i.e. by checking
>       within_error_injection_list. Similar disucssions happened for the
>       bpf_overrie_return helper.

2 typos: discussions and bpf_override_return ;)

>
>     * security hooks, this is expected to be cleaned up with the LSM
>       changes after the KRSI patches introduce the LSM_HOOK macro:
>
>         https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/
>
> - The attachment is currently limited to functions that return an int.
>   This can be extended later other types (e.g. PTR).
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
>  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 8 deletions(-)
>

[...]
