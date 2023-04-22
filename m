Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29126EB9FB
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDVPZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDVPZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 11:25:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4C71BD5
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 08:25:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso4032352a12.1
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682177102; x=1684769102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UprjCmplJBS+FwonoZVStpAcyGGCU2Uqao9e2KIUPY0=;
        b=bODF7xAYIYFt1ntxHofCS/oKCHcV1l8A0DkgF6/jR7h6un3qz4siFs1JqZDTi5uU4z
         6acdtqU4KLcWKySrDK7TcA6cae1/6SWuuDvadlllFdL19ohTJQGYEGaQlGy3la3k/zLA
         OATwoXDdJuZ+ep5BSTmMhpkWggbh9QaNkmVZPkbpGL2rjYxzJecaDzbtZLmQIUqzoMO9
         PEUTqwVb9+9zRoIQFMby8j9oUTV/hfb8H8ZTuhfjNl9irERIyVrgOH48BhphGYRBZzRO
         5cUMqL9t3wz4vJdczJ+PoQYUX7GDg6+9dGm9jv6w5d+ODCQT2U7UqAWhH9JVsh4TUse6
         Brmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682177102; x=1684769102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UprjCmplJBS+FwonoZVStpAcyGGCU2Uqao9e2KIUPY0=;
        b=NWOxjs5z9du9ws5xbMjmeQwAqRTITQHQlT+9ZDnTeVi3JCXrMUyq1KEjdPIlklRD6o
         zbCBKN4zj7hBbBxnnjUWq8BcsiiLQf82lI/XPrkXFZi4onNdXLXwDC0mwKL42Z7lgoqu
         paYmZJB14QN558Gg/dYNphVfU4MnW4NxLzzaryniPlc7deCB5oe0gg4tJ8PvbMdZhuW+
         e1qf9si+TXghkGUPqIUI+qMMmZnGjkRvN/DcjQwcYy1ZnKiwj4oin1kGm2EiZ2Tt6iUh
         J1idf4Jh3CCjGaeX+l+FVuf46TJzglgjvhe9Vc9daGsCw0uqMzeTruCipY+Izy0DOcMJ
         zAHg==
X-Gm-Message-State: AAQBX9fAm1XdGpjO9dqpf8t8nWLbA0lgIIYWnnm+yOoeoxdBiqqP6BV7
        RN2aIWbB6H1B1HWShgXbST7bYnIO/+1/I3rtJTU=
X-Google-Smtp-Source: AKy350Z8AO27J6ClkW0YtA0UxmfrmUGDFMjeSiRsOClckZgyF3hgzcTdNawlzk6j6Ke2RMPD2MiqWpKtNRuzrKLXoOg=
X-Received: by 2002:a05:6402:18c:b0:509:d476:3a12 with SMTP id
 r12-20020a056402018c00b00509d4763a12mr529153edv.34.1682177102014; Sat, 22 Apr
 2023 08:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <202304220903.fRZTJtxe-lkp@intel.com> <20230422073544.17634-1-fw@strlen.de>
In-Reply-To: <20230422073544.17634-1-fw@strlen.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 22 Apr 2023 08:24:50 -0700
Message-ID: <CAADnVQ+9Kn8XT9P7eMvXAbJvbcwiFuef7OjvEJboWzuNeuDE2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix link failure with NETFILTER=y INET=n
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 22, 2023 at 12:35=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Explicitly check if NETFILTER_BPF_LINK is enabled, else configs
> that have NETFILTER=3Dy but CONFIG_INET=3Dn fail to link:

netfilter=3Dy and inet=3Dn ? wow. Didn't realize such a config is possible.
Thanks for the quick fix.
Applied.

> > kernel/bpf/syscall.o: undefined reference to `netfilter_prog_ops'
> > kernel/bpf/verifier.o: undefined reference to `netfilter_verifier_ops'
