Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2955203A41
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgFVPFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 11:05:14 -0400
Received: from sym2.noone.org ([178.63.92.236]:42912 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbgFVPFO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 11:05:14 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49rCQ03hcZzvjcX; Mon, 22 Jun 2020 17:05:12 +0200 (CEST)
Date:   Mon, 22 Jun 2020 17:05:11 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] tools, bpftool: Define prog_type_name array
 only once
Message-ID: <20200622150510.nk6pkzsof2diolwt@distanz.ch>
References: <20200622140007.4922-1-tklauser@distanz.ch>
 <20200622140007.4922-2-tklauser@distanz.ch>
 <c961c0ee-424a-6f3b-942e-42fdc7ee9b95@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c961c0ee-424a-6f3b-942e-42fdc7ee9b95@isovalent.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-22 at 16:26:17 +0200, Quentin Monnet <quentin@isovalent.com> wrote:
> 2020-06-22 16:00 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> > Follow the same approach as for map_type_name. This leads to a slight
> 
> map_type_name looks unchanged in this series, could you please check
> your commit log?

Yes this patch intentionally shouldn't change map_type_name. The idea
was to say "do the same thing for prog_type_name name as is already done
for map_type_name". I can rephrase that to become more clear if you
want.

> > decrease in the binary size of bpftool.
> > 
> > Before:
> > 
> >    text	   data	    bss	    dec	    hex	filename
> >  401032	  11936	1573160	1986128	 1e4e50	bpftool
> > 
> > After:
> > 
> >    text	   data	    bss	    dec	    hex	filename
> >  399024	  11168	1573160	1983352	 1e4378	bpftool
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you.
