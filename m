Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664AB2A3634
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 22:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKBV71 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 16:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbgKBV7X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Nov 2020 16:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604354362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7KZ89OuP/usK31L4VTuh94nCFsWMsVQyhLdwv5Sf24=;
        b=YUiQK1hqrQU7pykhebyoL1QzAcQTcQAfMZXnYQNyuqrukqpqXj6o/iknRiiDWFaZyDAIBx
        0kZ0euZJdb1e3W6hoIA8o2YyQ68CQlKhUM0UsOTXK+sqhwU0U+6sqFW++lbxZ6SaFws3tw
        r5cE3zRRy3QD6tBC3fnNc/VO2hqEi7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-JCOMhlyPOIapgCiu4Q_VXg-1; Mon, 02 Nov 2020 16:59:16 -0500
X-MC-Unique: JCOMhlyPOIapgCiu4Q_VXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9806A6D242;
        Mon,  2 Nov 2020 21:59:14 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 22EB95B4D3;
        Mon,  2 Nov 2020 21:59:08 +0000 (UTC)
Date:   Mon, 2 Nov 2020 22:59:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201102215908.GC3597846@krava>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031223131.3398153-3-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 31, 2020 at 11:31:31PM +0100, Jiri Olsa wrote:
> We need to generate just single BTF instance for the
> function, while DWARF data contains multiple instances
> of DW_TAG_subprogram tag.
> 
> Unfortunately we can no longer rely on DW_AT_declaration
> tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
> 
> Instead we apply following checks:
>   - argument names are defined for the function
>   - there's symbol and address defined for the function
>   - function is generated only once
> 
> Also because we want to follow kernel's ftrace traceable
> functions, this patchset is adding extra check that the
> function is one of the ftrace's functions.
> 
> All ftrace functions addresses are stored in vmlinux
> binary within symbols:
>   __start_mcount_loc
>   __stop_mcount_loc

hum, for some reason this does not pass through bpf internal
functions like bpf_iter_bpf_map.. I learned it hard way ;-)
will check

jirka

