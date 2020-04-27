Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7091BA5A5
	for <lists+bpf@lfdr.de>; Mon, 27 Apr 2020 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0OCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Apr 2020 10:02:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgD0OCx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Apr 2020 10:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587996172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMjhOxtk+8SoCxZ3i3RAdelJOdXPNqRvKX1sCT6IWa4=;
        b=K5KaxEZefJ5DqNzcDMyGCUW/+PPMk8AkVA20NIyQM4qOV+2dDGtb3eS3PfJLGbSFjzrf4/
        3oUu+cv0vp74dOMSwKDL4JST3aMH4tJmqPFF4xb4bMWaH2Yt3lf1o32XvkRS29nryBGUOE
        xYxkWNlM28F3G82uZ/uVqY5q8KaDCvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-EP3LqXDvNWuq2rAxwiKJrg-1; Mon, 27 Apr 2020 10:02:48 -0400
X-MC-Unique: EP3LqXDvNWuq2rAxwiKJrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45316800688;
        Mon, 27 Apr 2020 14:02:47 +0000 (UTC)
Received: from carbon (unknown [10.40.208.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 908C26606C;
        Mon, 27 Apr 2020 14:02:41 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:02:40 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     brouer@redhat.com, bpf@vger.kernel.org, andriin@fb.com
Subject: Re: [PATCH] selftests/bpf: Copy runqslower to OUTPUT directory
Message-ID: <20200427160240.5e66a954@carbon>
In-Reply-To: <20200427132940.2857289-1-vkabatov@redhat.com>
References: <20200427132940.2857289-1-vkabatov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Apr 2020 15:29:40 +0200
Veronika Kabatova <vkabatov@redhat.com> wrote:

> $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
> binary in the $(OUTPUT) directory. As lib.mk expects all
> TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
> the OUTPUT directory, this results in an error when running e.g. `make
> install`:
> 
> rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
>        such file or directory (2)
> 
> Copy the binary into the OUTPUT directory after building it to fix the
> error.
> 
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> ---

Looks good to me

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

>  tools/testing/selftests/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 7729892e0b04..cb8e7e5b2307 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -142,6 +142,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ)
>  	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
>  		    OUTPUT=$(SCRATCH_DIR)/ VMLINUX_BTF=$(VMLINUX_BTF)   \
>  		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)
> +	@cp $(SCRATCH_DIR)/runqslower $(OUTPUT)/runqslower
>  
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

