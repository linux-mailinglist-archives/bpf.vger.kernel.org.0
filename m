Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2349DC92
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 09:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiA0IbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 03:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiA0IbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 03:31:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857DBC061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 00:31:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so1384577wme.0
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=btqiCHbeuN237nCi4TpQf1ArnU9Tz7af0C26zyiCSTk=;
        b=Ij9cFRhwg2wmTA43p3G8vHieI3XSBWHQ79g8RH+Hou6T6Dpa3lnraxxLD89O/TxLf+
         8jPyfsets6QFA/JIBT5UJkEIaCJmPmz83GwYDXwO0jq2fcFV4OHtIylDEjTTCazE4ea4
         45eVLguufWqCBVOSuyu7khRf46DKEJvezhb7mpUTKx8PywWdlAvMwe+AamdAjDeVVLu5
         et1uJy6LGjKFE1x3htJvsXB193Ed14fMueyW9/UVIpxsf6xAdda8OmVhAyXzehE5ycFo
         gGpyf8cNFjq9ZxyIjl/vai/tLzJsOy/GaPAjZHzPmEOEsWetwZ1RjV42C40w6z4W19mt
         Mj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=btqiCHbeuN237nCi4TpQf1ArnU9Tz7af0C26zyiCSTk=;
        b=yP0GbzRa6yLbgXfN4/Kfi1rtXqF4Rdnt9M38TuZ7hNDLyp7cX0rbY9y7qGhRoujc0O
         HIJexYG6TvvBVeedrssDd5FgbqTh7jcgtVtqRg6+hnP/CuYAmpbx5P6VuJwYdmbyIGS2
         mhyQaVGtRIh5N6rCY2L3bGraHwxUJLkQgOPJKdNwnfb3MBXtl+WikcKcyOw7PKqSbkZM
         uC0nrDxTLN4JzjsUYik2+EFNSnUAOBgMOkHnFWyqoTJuOUvw7zwfagaKvy3TfnOh6nCW
         zdD5wgpVA0cwWV+iRxeamyldQWcCxXkFWTnjNUfDcoqt4tf7y9c+9FaYO8xE6cYNuLyv
         fxvw==
X-Gm-Message-State: AOAM533rHCCwNF4/dkGdWwcpgYNNpcn7YYTp5e3swuGPVSowCvqRuca2
        P9hkCbZzaMduRgs0FwKtIQJoVSa8/neU2A==
X-Google-Smtp-Source: ABdhPJyntFHL8+4lYjN2vwUag8C0PkgkBC0BX9gxXfPegshYCHuNVE4L2CW1cfodpaLwFFxp1pUSlw==
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr2216690wmj.184.1643272268128;
        Thu, 27 Jan 2022 00:31:08 -0800 (PST)
Received: from erthalion.local (dslb-094-223-160-189.094.223.pools.vodafone-ip.de. [94.223.160.189])
        by smtp.gmail.com with ESMTPSA id z5sm6438544wmp.10.2022.01.27.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:31:07 -0800 (PST)
Date:   Thu, 27 Jan 2022 09:30:50 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
Subject: Re: [RFC PATCH] bpftool: Add bpf_cookie to perf output
Message-ID: <20220127083050.6v57vn5ngntrpgqg@erthalion.local>
References: <20220127082649.12134-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127082649.12134-1-9erthalion6@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, Jan 27, 2022 at 09:26:49AM +0100, Dmitrii Dolgov wrote:
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
>
>     $ bpftool perf
>     pid 83  fd 9: prog_id 5  bpf_cookie: 123  tracepoint  sched_process_exec

If I'm missing something, and it doesn't make sense, I would be glad to
hear if there are any best practices or intended ways of utilizing
bpf_cookie.
