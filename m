Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993BD2D9086
	for <lists+bpf@lfdr.de>; Sun, 13 Dec 2020 21:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgLMU3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Dec 2020 15:29:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbgLMU33 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 13 Dec 2020 15:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607891283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKQo1U5qUlDd3rxooekdaTivKSOdw/fBjhjxAEGtKr0=;
        b=Fr+j+iLvCx3D227Z+HiWEjwr06MiQLvvc/ltK0Ac9D2NSQcYCI9rvPTn5KVYg+ur3WtPLH
        sCcNQ+5/53MJpVaHGEfJvaJn+pyUAAq6p7KVnHLX3tUtYIc8YLb/d6jDvEGZ6DABESDFdD
        Uj3pHoNzVNxsTKSokSrsEdu6hbQ18C8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339--VKZLHK1N3SKTy0FI2xzXQ-1; Sun, 13 Dec 2020 15:28:01 -0500
X-MC-Unique: -VKZLHK1N3SKTy0FI2xzXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38DF215720;
        Sun, 13 Dec 2020 20:28:00 +0000 (UTC)
Received: from krava (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9EC8016C1F;
        Sun, 13 Dec 2020 20:27:58 +0000 (UTC)
Date:   Sun, 13 Dec 2020 21:27:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, acme@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH dwarves 0/2] Fix pahole to emit kernel module BTF
 variables
Message-ID: <20201213202757.GA482741@krava>
References: <20201211041139.589692-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211041139.589692-1-andrii@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 08:11:36PM -0800, Andrii Nakryiko wrote:
> Two bug fixes to make pahole emit correct kernel module BTF variable
> information.
> 
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> 
> Andrii Nakryiko (2):
>   btf_encoder: fix BTF variable generation for kernel modules
>   btf_encoder: fix skipping per-CPU variables at offset 0

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> 
>  btf_encoder.c | 61 +++++++++++++++++++++++++++++++++------------------
>  libbtf.c      |  1 +
>  libbtf.h      |  1 +
>  3 files changed, 42 insertions(+), 21 deletions(-)
> 
> -- 
> 2.24.1
> 

