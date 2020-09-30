Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D3827E7E7
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgI3Lw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 07:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728430AbgI3Lw2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 07:52:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601466747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B0+5QsOC490kg8lOk33IeFEtM+WAJ4uYFRpejxosuV4=;
        b=bLg1pRNB5aJwaVs6zrw3U7fVjQn/bO6qBCX+TLKhA7Coe3r/uKMU2In1H+cHpxInFbirw3
        Ezx2gIa2+Qb0ZVukK+lo9Jy8F9pgyql18W+OH37tZQrfwdP8R7mSvJKQzBvAqjQve2FeqB
        t4RJWgpViaXzkpnlFUYLlcmZ2/C75zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-DnHkcoeeMcWHSBXbJ4jVlw-1; Wed, 30 Sep 2020 07:52:23 -0400
X-MC-Unique: DnHkcoeeMcWHSBXbJ4jVlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44BEC188C120;
        Wed, 30 Sep 2020 11:52:21 +0000 (UTC)
Received: from krava (unknown [10.40.194.241])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F1505C1C4;
        Wed, 30 Sep 2020 11:52:17 +0000 (UTC)
Date:   Wed, 30 Sep 2020 13:52:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, jolsa@kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix alignment of .BTF_ids
Message-ID: <20200930115217.GA3839577@krava>
References: <20200930093559.2120126-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930093559.2120126-1-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 11:36:01AM +0200, Jean-Philippe Brucker wrote:
> Fix a build failure on arm64, due to missing alignment information for
> the .BTF_ids section:
> 
> resolve_btfids.test.o: in function `test_resolve_btfids':
> tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:140:(.text+0x29c): relocation truncated to fit: R_AARCH64_LDST32_ABS_LO12_NC against `.BTF_ids'
> ld: tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:140: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
> 
> In vmlinux, the .BTF_ids section is aligned to 4 bytes by vmlinux.lds.h.
> In test_progs however, .BTF_ids doesn't have alignment constraints. The
> arm64 linker expects the btf_id_set.cnt symbol, a u32, to be naturally
> aligned but finds it misaligned and cannot apply the relocation. Enforce
> alignment of .BTF_ids to 4 bytes.
> 
> Fixes: cd04b04de119 ("selftests/bpf: Add set test to resolve_btfids")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/resolve_btfids.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 8826c652adad..6ace5e9efec1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -28,6 +28,12 @@ struct symbol test_symbols[] = {
>  	{ "func",    BTF_KIND_FUNC,    -1 },
>  };
>  
> +/* Align the .BTF_ids section to 4 bytes */
> +asm (
> +".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
> +".balign 4, 0;                            \n"
> +".popsection;                             \n");
> +

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  BTF_ID_LIST(test_list_local)
>  BTF_ID_UNUSED
>  BTF_ID(typedef, S)
> -- 
> 2.28.0
> 

