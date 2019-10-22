Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52EDDDFE59
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 09:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfJVHfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 03:35:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726160AbfJVHfu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 03:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571729749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqnUKo3S/v+DMaC4AeuuAiOBCkX6zM+VypHM27CSLgk=;
        b=JNx93pDBQQJUOpeIhWJi6nDt9q09qhFNokrVb4X8sXfWIYMTjb3jFULUA0uC4gmf3wkZLC
        I+w1fDUDZEqBhq6qO7/Bk1nGfx/Ebm7IIk9A97DTvJ1V/adCi/NfPaDn2r18xi9KBP3Nzr
        wI3TCJRBX6xSZkenhZuPv7rDRiJJ/1g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-8cfYdUl4OXGuB2EhrMyKVQ-1; Tue, 22 Oct 2019 03:35:44 -0400
Received: by mail-lf1-f70.google.com with SMTP id n26so27801lfe.17
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 00:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DqnUKo3S/v+DMaC4AeuuAiOBCkX6zM+VypHM27CSLgk=;
        b=pocGjIqnaXiDDWQ1DfH0UDtsI3eH5Cx/a0B0t2LcayhVbTkFUM/X3scXDsuxgDVt8o
         2xnSK83W8JZsv8UL71VQO6Je+lzVvkvJxk506iMN2raMGiJoxUxDHMlZCv7++0JpZ5Xy
         pECQx7rlCkORSi/bRnWjcz1dO22jkv4kjkd8xf/l8uHHEcQ0fj7bz5wuM20Vk8iVyCYq
         YQ3UQ2jPbx2F9jAOKvX0bhBnYIDa7NjTArPREvkX5vdhHCu6kOnMAlP6VvpGC4WqZzp5
         2OTq7Vb/rTcgeBtnqrGMkJy74op4fjanBdH67xaTar8rPGROfZRJlWGCeAHa3b4DD5Ws
         rM8g==
X-Gm-Message-State: APjAAAVhebex5OWQdKMwLb1aiu1USdX1sjZ7ITzWk8DNjpt5C4sfnhYM
        8JCNYu6op2U60lNkKVDFH1qYEXBL8gzNn2drCawa7Y2fRaPcdJ1COAkOrnlqrjtsa+wppYNA9Vr
        kZmNG6APDzvJ+
X-Received: by 2002:a2e:6101:: with SMTP id v1mr17785801ljb.132.1571729743088;
        Tue, 22 Oct 2019 00:35:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjbZ9S8P/PhkdhD0q8yTvPk2jIKTwlJxy3YnyEuqRyLVmXnHeuMGWT3JSEDGyuxE0xYB4xnA==
X-Received: by 2002:a2e:6101:: with SMTP id v1mr17785784ljb.132.1571729742798;
        Tue, 22 Oct 2019 00:35:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id i128sm7770121lfd.6.2019.10.22.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 00:35:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9A4911804B1; Tue, 22 Oct 2019 09:35:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH bpf-next v3] libbpf: use implicit XSKMAP lookup from AF_XDP XDP program
In-Reply-To: <20191022072206.6318-1-bjorn.topel@gmail.com>
References: <20191022072206.6318-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 09:35:40 +0200
Message-ID: <87ftjlp703.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 8cfYdUl4OXGuB2EhrMyKVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> In commit 43e74c0267a3 ("bpf_xdp_redirect_map: Perform map lookup in
> eBPF helper") the bpf_redirect_map() helper learned to do map lookup,
> which means that the explicit lookup in the XDP program for AF_XDP is
> not needed for post-5.3 kernels.
>
> This commit adds the implicit map lookup with default action, which
> improves the performance for the "rx_drop" [1] scenario with ~4%.
>
> For pre-5.3 kernels, the bpf_redirect_map() returns XDP_ABORTED, and a
> fallback path for backward compatibility is entered, where explicit
> lookup is still performed. This means a slight regression for older
> kernels (an additional bpf_redirect_map() call), but I consider that a
> fair punishment for users not upgrading their kernels. ;-)
>
> v1->v2: Backward compatibility (Toke) [2]
> v2->v3: Avoid masking/zero-extension by using JMP32 [3]
>
> [1] # xdpsock -i eth0 -z -r
> [2] https://lore.kernel.org/bpf/87pnirb3dc.fsf@toke.dk/
> [3] https://lore.kernel.org/bpf/87v9sip0i8.fsf@toke.dk/
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

