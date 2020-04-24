Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886F1B80B4
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgDXUco (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 16:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36981 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgDXUcn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 16:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587760363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h1X0YGiakx0c7C8Tvxw3Lw8N5F4IF1B+B1haaP9Xeu0=;
        b=GgACXcEVzKXSr41F5mIRui0TWynUr72F5f1mopSdiEwQk+aK69Ei7013bThtHJmnt8A5N0
        dtSh2zuHym7GJaTMv01nReSQypY5Qu98oWJzEuyS92MrHTOMTemXhItPWzRZZsauWGRVgQ
        n/ygF6zhiMEA6H9L3rnyImZZRL+XASU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-G7VY4VIwOUajk3m8D9r-Hw-1; Fri, 24 Apr 2020 16:32:36 -0400
X-MC-Unique: G7VY4VIwOUajk3m8D9r-Hw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC9051895A2F;
        Fri, 24 Apr 2020 20:32:34 +0000 (UTC)
Received: from treble (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E12145C1D0;
        Fri, 24 Apr 2020 20:32:33 +0000 (UTC)
Date:   Fri, 24 Apr 2020 15:32:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] Revert "objtool: Skip samples subdirectory"
Message-ID: <20200424203231.b4lonbdgzkoxf7ug@treble>
References: <20200423073929.127521-1-masahiroy@kernel.org>
 <20200423073929.127521-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423073929.127521-3-masahiroy@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 23, 2020 at 04:39:15PM +0900, Masahiro Yamada wrote:
> This reverts commit 8728497895794d1f207a836e02dae762ad175d56.
> 
> This directory contains no object.
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  samples/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/samples/Makefile b/samples/Makefile
> index f8f847b4f61f..5ce50ef0f2b2 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for Linux samples code
> -OBJECT_FILES_NON_STANDARD := y
>  
>  obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS)	+= binderfs/
>  obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
> -- 
> 2.25.1

Hm, somehow I was thinking this would work recursively for
subdirectories.  Anyway, you're right:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

