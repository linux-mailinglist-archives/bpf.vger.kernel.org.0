Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8481F34D544
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC2QkH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhC2Qjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 12:39:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4049C061574
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 09:39:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 131so20035139ybp.16
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8ggmxZb7lnne8LufmZiqJUJ4OmflVB1olvE1emPiNj8=;
        b=lRXc4mS4kN1vhK9bcARPdF77Fymzf5hfUrxU7RGKPJy8Hr/JVw7R1yb6sdmwsNWISb
         hpfHQOLSUhWu7Ivuh2onLvZ58McwGm2ipzwqLJBTYwpkFvuvLkMatUIY8lrhGQ255rrA
         lmA2P9dPsbgjiqVml/auN5E3xqUr1ny6A7v7xkifAHDE5quDGLuDblxqQM/YRW0NpWaX
         sEUuYWIf82EyBQulH+Pyv/dsO/EAZOgMnO4cuxV1TMjucxNGwDocHmVRyryE6QXvykJD
         CO3R/WBe8LgwG2MvNIStqYdHzt4ApVCNis8TxT3CzVdUU02TW2mZSZsL0XamWB3QEDWz
         9VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8ggmxZb7lnne8LufmZiqJUJ4OmflVB1olvE1emPiNj8=;
        b=MNFUI2wurKA4TseVy6wMhXfPMQbTTEJdQ5Iy4YtzDaoB/v0xwI17s0RxG99ixixdxm
         wUPDaOoS4LJE1sIwuQC75BdspOBQNq1oSzLxlF1OsiJ5t4FcVM/bY80cHy/sQzZPGwnS
         7hPXxYw/gGod+0FOmyIJKa6+NnV+z/BBvVVvuA9gSp2xspDOzUJjr6HtCTcRqbEy3+yn
         feXfhoeaHSQr1g2tqXjm8c8SoDoPIylm78WyGmHiSYmxi4qgbvEG8xQW+VfJc2rStu7y
         04kqEcJqohUbgiU3lF8EbvvhktuFMNeZkzYhzeaUMEk98LN8KpkZRLLmdwYXIkInjj1O
         CLkA==
X-Gm-Message-State: AOAM530qK/uGbE1TzKbaiOgyzeLF2dJF6iuKpZQHVBx+CAB9juKtPF0O
        F6l7N7ujkg4vZky+qQP0UcapXNI=
X-Google-Smtp-Source: ABdhPJwwXLIwIZp20FRDoeyyu4GL72dKho2qVRx1W3QpRo75b4KIhn2npUB+lJxW75c1y43RBls73VU=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:ede7:5698:2814:57c])
 (user=sdf job=sendgmr) by 2002:a25:4f03:: with SMTP id d3mr37391057ybb.19.1617035988274;
 Mon, 29 Mar 2021 09:39:48 -0700 (PDT)
Date:   Mon, 29 Mar 2021 09:39:46 -0700
In-Reply-To: <20210329162416.2712509-1-sdf@google.com>
Message-Id: <YGIC0u8i8ioy1Uvm@google.com>
Mime-Version: 1.0
References: <20210329162416.2712509-1-sdf@google.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Fix warnings
From:   sdf@google.com
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/29, Stanislav Fomichev wrote:
> * make eprintf static, used only in main.c
> * initialize ret in eprintf
> * remove unused *tmp

> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/bpf/resolve_btfids/main.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/tools/bpf/resolve_btfids/main.c  
> b/tools/bpf/resolve_btfids/main.c
> index 80d966cfcaa1..a650422f7430 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -115,10 +115,10 @@ struct object {

>   static int verbose;

> -int eprintf(int level, int var, const char *fmt, ...)
> +static int eprintf(int level, int var, const char *fmt, ...)
>   {
>   	va_list args;
> -	int ret;
> +	int ret = 0;

>   	if (var >= level) {
>   		va_start(args, fmt);
> @@ -403,7 +403,7 @@ static int symbols_collect(struct object *obj)
>   	 * __BTF_ID__* over .BTF_ids section.
>   	 */
>   	for (i = 0; !err && i < n; i++) {
> -		char *tmp, *prefix;
> +		char *prefix;
>   		struct btf_id *id;
>   		GElf_Sym sym;
>   		int err = -1;
> --
> 2.31.0.291.g576ba9dcdaf-goog


Looks like that 'int err = -1' is also unused.
I'll respin, please ignore this one. Sorry for the noise.
