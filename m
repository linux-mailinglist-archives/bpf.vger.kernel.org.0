Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739C81C84DC
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgEGIcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGIcF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 04:32:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A2C061A10
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 01:32:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so5262240wrn.6
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+JmkWdzNfOyO34f9b8/zrVWrdF5KD/lhda69COc19Y=;
        b=kYW2GJLewspb2CxoSxc2Ux05C1Qe6rKLym04boLSBfpUPV0B3If81y8/dHpwEq4pAm
         0egzKKEZY2yC+v0ZmGgKVc15v4a2T/8t0+11hL+R5tOdN22gePJ3q/2+IIIPSAhLvTJf
         VHe5Z8Gmjkb9Xz/Xblk/S1XZAzrHLOH/wEf6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+JmkWdzNfOyO34f9b8/zrVWrdF5KD/lhda69COc19Y=;
        b=plwaR8gM9xoo6+opn9sw38K6BG4M/6bKhjREVIHIGCTbR58UGNDLrXrztIFdJ/Y+jN
         iDvHqXO+ew/izTVkEh4AstzD3ONASHliNeLSGHuzycv6UWmuw+Y3mZtJVBL6sNq1T3n3
         /h9sw8ANZARl6YGE8Y+yDWobODy2JixWqx52xVITRcabLsTh6CeGVkMAUiE1jxfwxo8i
         G40aw7Ju5AOOtqINA8pjU2YrwE6PmDwjQyYH957i6b/uPS7StdXDUTWNhKQCq4NCrKI1
         ES1a9ADnSFk85pJ+XoU76x/IvbJ9ejeHFd73JeoZ6ufPv+bpkkfzIB+mALxa6Rec7yg9
         C/cA==
X-Gm-Message-State: AGi0PuYo9rxjZ/6ntvmMnoOL5KvyUUEf7ArprGA7+HARRPNLH9aNul2e
        TH/PCc7kJ/Bsw5+141oxf9m5jg==
X-Google-Smtp-Source: APiQypL2Oei0a5RAzedY2tb9ChiXYBkfvHTUWX1t1+uybHNhmZynTpSDUtdzE9205O6GkVkfwpyHEA==
X-Received: by 2002:adf:9d8b:: with SMTP id p11mr13979473wre.322.1588840323831;
        Thu, 07 May 2020 01:32:03 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id c190sm7197294wme.10.2020.05.07.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 01:32:03 -0700 (PDT)
Date:   Thu, 7 May 2020 10:31:57 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     lmb@cloudflare.com, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, ast@kernel.org
Subject: Re: [bpf-next PATCH 03/10] bpf: selftests, sockmap test prog run
 without setting cgroup
Message-ID: <20200507102902.6b27705c@toad>
In-Reply-To: <158871183500.7537.4803419328947579658.stgit@john-Precision-5820-Tower>
References: <158871160668.7537.2576154513696580062.stgit@john-Precision-5820-Tower>
        <158871183500.7537.4803419328947579658.stgit@john-Precision-5820-Tower>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 05 May 2020 13:50:35 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> Running test_sockmap with arguments to specify a test pattern requires
> including a cgroup argument. Instead of requiring this if the option is
> not provided create one
> 
> This is not used by selftest runs but I use it when I want to test a
> specific test. Most useful when developing new code and/or tests.
> 
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c |   28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 6bdacc4..a0884f8 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -1725,6 +1725,7 @@ int main(int argc, char **argv)
>  	int opt, longindex, err, cg_fd = 0;
>  	char *bpf_file = BPF_SOCKMAP_FILENAME;
>  	int test = PING_PONG;
> +	bool cg_created = 0;
>  
>  	if (argc < 2)
>  		return test_suite(-1);
> @@ -1805,13 +1806,25 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (argc <= 3 && cg_fd)
> -		return test_suite(cg_fd);
> -
>  	if (!cg_fd) {
> -		fprintf(stderr, "%s requires cgroup option: --cgroup <path>\n",
> -			argv[0]);
> -		return -1;
> +		if (setup_cgroup_environment()) {
> +			fprintf(stderr, "ERROR: cgroup env failed\n");
> +			return -EINVAL;
> +		}
> +
> +		cg_fd = create_and_get_cgroup(CG_PATH);
> +		if (cg_fd < 0) {
> +			fprintf(stderr,
> +				"ERROR: (%i) open cg path failed: %s\n",
> +				cg_fd, optarg);

Looks like you wanted to log strerror(errno) instead of optarg here.

> +			return cg_fd;
> +		}
> +
> +		if (join_cgroup(CG_PATH)) {
> +			fprintf(stderr, "ERROR: failed to join cgroup\n");
> +			return -EINVAL;
> +		}
> +		cg_created = 1;
>  	}
>  
>  	err = populate_progs(bpf_file);
> @@ -1830,6 +1843,9 @@ int main(int argc, char **argv)
>  	options.rate = rate;
>  
>  	err = run_options(&options, cg_fd, test);
> +
> +	if (cg_created)
> +		cleanup_cgroup_environment();
>  	close(cg_fd);
>  	return err;
>  }
> 

