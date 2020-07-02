Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2148E212524
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 15:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgGBNro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 09:47:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21022 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729051AbgGBNrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 09:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593697662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhNMrvUTLv8bErz+LaXBRBGMN/d2djhjfAfd7ZbHLPU=;
        b=DMAV+WjTxEF0bDpf1KooENz8MaODiCjE85mdtP0p1KcCXSDUmjtYu9obP8Wb2OvCtm2CED
        TGIxjdYSgSZxpHSnJTENKg00FWLBTxD6aEY9WC3ZsPpKMu7rQp02BL/eg/EWSszKswtc6D
        P5ghS1okrrV/r1zGlk6jkPCN+E1WABA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-_aYRLZAAPOOEDyoeAcrTPw-1; Thu, 02 Jul 2020 09:47:40 -0400
X-MC-Unique: _aYRLZAAPOOEDyoeAcrTPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05EB78015FE;
        Thu,  2 Jul 2020 13:47:39 +0000 (UTC)
Received: from carbon (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402B95C1C5;
        Thu,  2 Jul 2020 13:47:29 +0000 (UTC)
Date:   Thu, 2 Jul 2020 15:47:28 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com, brouer@redhat.com
Subject: Re: [PATCH bpf-next V3 1/3] selftests/bpf: test_progs indicate to
 shell on non-actions
Message-ID: <20200702154728.6700e790@carbon>
In-Reply-To: <159363984736.930467.17956007131403952343.stgit@firesoul>
References: <159363976938.930467.11835380146293463365.stgit@firesoul>
        <159363984736.930467.17956007131403952343.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 01 Jul 2020 23:44:07 +0200
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> When a user selects a non-existing test the summary is printed with
> indication 0 for all info types, and shell "success" (EXIT_SUCCESS) is
> indicated. This can be understood by a human end-user, but for shell
> scripting is it useful to indicate a shell failure (EXIT_FAILURE).
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 54fa5fa688ce..da70a4f72f54 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -687,5 +687,8 @@ int main(int argc, char **argv)
>  	free_str_set(&env.subtest_selector.whitelist);
>  	free(env.subtest_selector.num_set);
>  
> +	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
> +		return EXIT_FAILURE;

We should use another return code as indication, else the shell script
cannot tell the difference between no-test-selected and failed-test.
Normally I would request a V4 (from myself I guess), but this have
already been merged, so I'll send a followup patch.

> +
>  	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
>  }
> 

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

