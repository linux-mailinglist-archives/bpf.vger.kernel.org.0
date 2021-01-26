Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C6304CC6
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 23:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbhAZWzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404841AbhAZT51 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Jan 2021 14:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611690961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qweHmzp0/bOx+ed2pndkJ/15/YgKnfW7IY89o43v8JM=;
        b=f7e4X7LMsiQZK/xshpPOIbovRJGBWVZqMeWFrBZWS5OYCqdpRHJCMfQ9xGMmvmugj4bmqV
        tApG1Q3GkcDn1xwYSUbqv9BCJNG+0v6vuv+lrp3T47dkypstsBtVgibaL5b+fgGD9Up6Uv
        G0A7RMIu8dzNM16IzDrkOOQn53zVddw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-pvalz7IONieyrmKKF4--GA-1; Tue, 26 Jan 2021 14:55:57 -0500
X-MC-Unique: pvalz7IONieyrmKKF4--GA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D01192AB7E;
        Tue, 26 Jan 2021 19:55:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.149])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B2A62BCDB;
        Tue, 26 Jan 2021 19:55:43 +0000 (UTC)
Date:   Tue, 26 Jan 2021 20:55:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org,
        ast@kernel.org, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/4] BTF ELF writing changes
Message-ID: <20210126195542.GB120879@krava>
References: <20210125130625.2030186-1-gprocida@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 01:06:21PM +0000, Giuliano Procida wrote:
> Hi.
> 
> This follows on from my change to improve the error handling around
> llvm-objcopy in libbtf.c.
> 
> Note on recipients: Please let me know if I should adjust To or CC.
> 
> Note on style: I've generally placed declarations as allowed by C99,
> closest to point of use. Let me know if you'd prefer otherwise.
> 
> 1. Improve ELF error reporting
> 
> 2. Add .BTF section using libelf
> 
> This shows the minimal amount of code needed to drive libelf. However,
> it leaves layout up to libelf, which is almost certainly not wanted.
> 
> As an unexpcted side-effect, vmlinux is larger than before. It seems
> llvm-objcopy likes to trim down .strtab.
> 
> 3. Manually lay out updated ELF sections
> 
> This does full layout of new and updated ELF sections. If the update
> ELF sections were not the last ones in the file by offset, then it can
> leave gaps between sections.
> 
> 4. Align .BTF section to 8 bytes
> 
> This was my original aim.
> 
> Regards.
> 
> Giuliano Procida (4):
>   btf_encoder: Improve ELF error reporting
>   btf_encoder: Add .BTF section using libelf
>   btf_encoder: Manually lay out updated ELF sections
>   btf_encoder: Align .BTF section to 8 bytes

hi,
I can't apply this on dwarves git master, which commit is it based on?

thanks,
jirka

> 
>  libbtf.c | 222 +++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 175 insertions(+), 47 deletions(-)
> 
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 

