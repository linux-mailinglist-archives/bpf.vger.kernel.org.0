Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6482AC242
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 18:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbgKIR3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 12:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbgKIR3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 12:29:14 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D951C2083B;
        Mon,  9 Nov 2020 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604942954;
        bh=URxhAbdWRnIobZgwKvGd10B8IykTwqEUcy2vRqU5tG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z28Z2XbbCxdttDIOAI1B3c4rOh3tR/nhMXqlsKemHd2+vZn2OYNjmmrLqJW5ez9r1
         jD/1BkulT5r/s7JuCyrfErSfjK0hyDg12C79a/Ra5dRyF0X9p4raIMuiaTZ2EqClSP
         FEHhyGWbDDKimYITMZQrKSwH8pVQi+AxI3gz5NUo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DC26411D1; Mon,  9 Nov 2020 14:29:11 -0300 (-03)
Date:   Mon, 9 Nov 2020 14:29:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCHv4 0/3] pahole/kernel: Workaround dwarf bug for function
 encoding
Message-ID: <20201109172911.GA340169@kernel.org>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <CAEf4BzZXOyA0gROk2=G1R+m7gHcqTZHpE9L2G_EBCZET3FpzAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZXOyA0gROk2=G1R+m7gHcqTZHpE9L2G_EBCZET3FpzAw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Nov 06, 2020 at 02:56:45PM -0800, Andrii Nakryiko escreveu:
> On Fri, Nov 6, 2020 at 2:25 PM Jiri Olsa <jolsa@kernel.org> wrote:
 
> For the series:
 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, applied, testing now.

- Arnaldo

