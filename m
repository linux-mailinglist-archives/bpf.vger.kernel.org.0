Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18117342A14
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 03:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCTCrb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 22:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhCTCrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 22:47:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95620C061761
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 19:47:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v3so4931056pgq.2
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 19:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BqgpZrC/vsBSKDyBx4gXAevx4lPfgIM8T3WPpKhMTFA=;
        b=TZtayiolXZeOCLLiIo1ZrMeH2XSf7dOw7R2evPOANELGYSBydDN9v4q2zxrDA/jVyL
         fkIzhwdRXrTVTFb78JUqeTTQcDKHXmpsO66V9rrKz/u9XZ9ZK2P9KHJks6zg0lsFUDI0
         UZ4b09mgpWdKCOryxf9seQLNuUf7xB3tebnjuw4G1LOowC20shW3iEDcSuZtLZtapH3T
         WNs8A2hOApMzKrkxewBeB6CwSK6wu/uxdOguc332B6juCtB7IxYlWGGa2/dxtK0AXLG+
         lFm4OmaoN3OK5V4CrlNXQF1akAk1zpPwHImqCy2Fo2q7rvp6FdiuAi8jMaBvuWkB2vbk
         n8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqgpZrC/vsBSKDyBx4gXAevx4lPfgIM8T3WPpKhMTFA=;
        b=V1pYfbBRUAsFxLaQ/lK6qHrfD5GpB03UsgFUlmoG4DOA15Hr9s9+Or3nbQyQRnk/R7
         tulv2U6FqeQY1DKvzONwd/KuhwyX+3ozalKRqzRmou5knMQ+uQXpPzlSKmoCxqZegH6+
         qIb6xKRvarFu/T1cy6cx/HAyg/5RGQtAtFxVLl6qGJeOJXT2cIIQOCgINRo4CnBVo4Gu
         UxRISsubRerenZLcFVCmWfE+wcMHW98HZD13uih7TiCHJZA9rcpJXlQF1OtL6k+v3Wyd
         0o84fHxgYgYct3Ab4EDpSuXSguMBI8anFCucxbZ+2UMKvhmWJuoDz1XRKIqwrklRQ4E0
         Htog==
X-Gm-Message-State: AOAM532Mr/yjZZBR2v9NjpkXUVKOqa9pufk1SDz9c5J6N8yUlRLuZ3L3
        IOQydw7kSw132GyIqKUl4IbKWpLbF5Q=
X-Google-Smtp-Source: ABdhPJza3MTsndFgI0Mzy5v14oYhLl44gdb9o2fJ/cHEfJkb39NvHD4n0joquJd5pO+WLAPGKPAxPA==
X-Received: by 2002:a63:fa52:: with SMTP id g18mr14064931pgk.193.1616208427174;
        Fri, 19 Mar 2021 19:47:07 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:343d])
        by smtp.gmail.com with ESMTPSA id k11sm6326807pjs.1.2021.03.19.19.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 19:47:06 -0700 (PDT)
Date:   Fri, 19 Mar 2021 19:47:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
Message-ID: <20210320024704.adg6xknxtznba5ng@ast-mbp>
References: <20210319031231.3707705-1-yhs@fb.com>
 <20210319031236.3709026-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319031236.3709026-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 08:12:36PM -0700, Yonghong Song wrote:
> -static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
> -					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
> +static inline int bpf_cgroup_storage_set(struct bpf_cgroup_storage
> +					 *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
>  {
>  	enum bpf_cgroup_storage_type stype;
> +	int i;
> +
> +	preempt_disable();
> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != NULL))
> +			continue;
> +
> +		this_cpu_write(bpf_cgroup_storage_info[i].task, current);
> +		for_each_cgroup_storage_type(stype)
> +			this_cpu_write(bpf_cgroup_storage_info[i].storage[stype],
> +				       storage[stype]);
> +		break;
> +	}
> +	preempt_enable();
> +
> +	if (i == BPF_CGROUP_STORAGE_NEST_MAX) {
> +		WARN_ON_ONCE(1);
> +		return -EBUSY;
> +	}
> +	return 0;

The extra 'if' probably will be optimized by the compiler,
but could you write it like this instead:
+       int err = 0;
..
+		for_each_cgroup_storage_type(stype)
+			this_cpu_write(bpf_cgroup_storage_info[i].storage[stype],
+				       storage[stype]);
+		goto out;
+	}
+       err = -EBUSY;
+	WARN_ON_ONCE(1);
+    out:
+	preempt_enable();
+	return err;

Also patch 2 should be squashed into patch 1,
since patch 1 alone makes bpf_prog_test_run() broken.
(The WARN_ON_ONCE should trigger right away on test_run without patch 2).

Another nit:
Is title of the patch "fix NULL pointer dereference" actually correct?
It surely was correct before accidental tracing overwrite was fixed.
But the fix is already in bpf tree.
Do you still see it as NULL deref with that 3 min reproducer?
