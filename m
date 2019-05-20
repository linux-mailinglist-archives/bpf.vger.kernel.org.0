Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D07240BE
	for <lists+bpf@lfdr.de>; Mon, 20 May 2019 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfETS5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 May 2019 14:57:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38039 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfETS5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 May 2019 14:57:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id 14so13500557ljj.5
        for <bpf@vger.kernel.org>; Mon, 20 May 2019 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmaVPUNIZXzoguiohx42nQv5edtRi7vwn1kzPXHaCDU=;
        b=fMyll/PYRqDhUKiFB8FWnKnTIEQzIkiza71tvGxxVJhYoLtma2pufkLzZrNJzfHMCQ
         DEQUyJfZ/FKF9qXw4Gszyc7Cx/Wchwc6YJmaz6m/TMqJHRmLqjSWQnFpmV3uyA7JmLbe
         merYv5HX8zgk+6qeaa+yLv93n/+XXh57JMhmTAsXu/qsGMm4RTYfTixRoIzrDzByGpEV
         t498nAncnts0ff/6jHnDXDkJy+A4K6WC7xkUSaeb3OLLNwzfPKZPtPCFmrURE1bnpspH
         h0Mna6z+leiSlSL+sberZ70d7qdflrvzfoSwWOx88e+dDllUB5N64Y+xGHQt4tv6UOVs
         yt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmaVPUNIZXzoguiohx42nQv5edtRi7vwn1kzPXHaCDU=;
        b=T+FBEXlQVxOagJxbuwVxbiS7UMcR1HdsKT0E/TqyGXbH99J24gzOboOg2qnWLjcGeY
         wFA3mOXrdqN+x42cjVZyezbHRoM34EHGeFUPLeh0q0EgIDqAaQive61TCiWRba8ul0dg
         bUQYTMhBgCZGkiQKNMCYnUCAl+ozNDfg36wYOj9RYVzr7wYfbqjJvVpnqC6kLSjSZf4E
         ibhE4hishfrmeZ3jq6lNaGc3jiB5XbNfPHU7G9rddz3Qma53Sz+EWUzrm10spRM+wLIz
         NCAVXdasQ/Ns80/weSsnb3kt22jkSFlx3agO8Ox8NCgkKRnoGfF+EGMfvVasbKOnhmRJ
         2QCw==
X-Gm-Message-State: APjAAAUHw5YS7TJ+PI63uMOUAG/NwvJP8nCl/Dr63I+tzuKgT35TBcQH
        tjFAUn81iP0DTVufuwZdzIm3XQTBWynFkubxGx3HMQ==
X-Google-Smtp-Source: APXvYqy6M9AYAHvKJNCbUtN+nVQJi5irsspzQdgBoUYpuK5uXs+rCoPdY/21xnEcQ0CBbK70aIgXROavyXsEF4+arOE=
X-Received: by 2002:a2e:9d4e:: with SMTP id y14mr12542742ljj.199.1558378669341;
 Mon, 20 May 2019 11:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190517212117.2792415-1-kafai@fb.com>
In-Reply-To: <20190517212117.2792415-1-kafai@fb.com>
From:   Joe Stringer <joe@isovalent.com>
Date:   Mon, 20 May 2019 11:57:37 -0700
Message-ID: <CADa=Ryxc8cU8mx7i91GXjT+b4md3c01hqja9oVMZxSbbR+OVPw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Check sk_fullsock() before returning from bpf_sk_lookup()
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 17, 2019 at 2:21 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> The BPF_FUNC_sk_lookup_xxx helpers return RET_PTR_TO_SOCKET_OR_NULL.
> Meaning a fullsock ptr and its fullsock's fields in bpf_sock can be
> accessed, e.g. type, protocol, mark and priority.
> Some new helper, like bpf_sk_storage_get(), also expects
> ARG_PTR_TO_SOCKET is a fullsock.
>
> bpf_sk_lookup() currently calls sk_to_full_sk() before returning.
> However, the ptr returned from sk_to_full_sk() is not guaranteed
> to be a fullsock.  For example, it cannot get a fullsock if sk
> is in TCP_TIME_WAIT.
>
> This patch checks for sk_fullsock() before returning. If it is not
> a fullsock, sock_gen_put() is called if needed and then returns NULL.
>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Cc: Joe Stringer <joe@isovalent.com>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---

Acked-by: Joe Stringer <joe@isovalent.com>
