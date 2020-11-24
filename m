Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52302C1E86
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 07:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgKXGxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 01:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbgKXGxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 01:53:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4FDC0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 22:53:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k5so3760920plt.6
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 22:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p+l/2AKanwkBdtTXre3SxzHgL3ezUBEN38BPwN6Qxmc=;
        b=MYT9WXzTHf927Xr6FZSWRSMP8hDOHK8IFV2JxfGhdXwsWoXTMNue4sjOl1hfanBHm+
         R0Erl5WDdzZRrkw23oRF4k4550JJzKGryVu0Ou6zipOLpCb2RLoNAsn7xXt4Xkp9pArv
         oqXmvp/BMOLvFXdJOIff3UVjj/C4M/xpSEs11px2tFzUGE1006zC7DAgFfyeSrCM6GUX
         W0K9xYtGejkoWfbNTOR5wtL/A8s9kOUH7X52dipF8iTzhOEryNwyIEEjiu8iA6hSc5Kx
         W6qWigBterrruZ+RfFNCmK3TsnCLvNAzCc/gUPBVspFphTKgS1RyZsIeKEsk5IUXqw7G
         fmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p+l/2AKanwkBdtTXre3SxzHgL3ezUBEN38BPwN6Qxmc=;
        b=dUQ2EPKILhUsPhMdTPH7/9/8KPQ18WcGm9Z0cZ2IZc/78LVLP9HGfWnPLXYQEbq01z
         +CWR7AsBrLAeOx/IvwOuh48hnqosvct8EqUEL+6PkdjjzoQxH3oQm5ADCm1wZPH+TyOG
         4+9lhUTj5ormm+1Oc0cKLUEgtyl1+uNGpE8RHk/kj6EBcXa35rW4m3i72+k6rAN47SwG
         PqO7jGiSgrbdT4Ry2fZ1bvJKfM7DCqz3+5oO2EmvhAcagOwJ81wVvB1ZhIzCPffcFUkf
         NlZfIXZY9CD6sANFvOxjWtsOeS0FISaoU7FmkBSKjFBX8xtFxZts4g+80IoXAIIQFL5u
         UT/w==
X-Gm-Message-State: AOAM531IKgzB1bu4OOr3PzXSdOMzT6jsldtkg3IJEIp/0Vv89JVdAp3u
        4r3rqaL/OUE/XnjYPC/8VyY=
X-Google-Smtp-Source: ABdhPJxCU79ZRJcSHpLgUKS+0WytGMHH3KCGNzXOuRcNWtPvAAsBya9nd3n4Kivo8LfjsnBwr7rnlA==
X-Received: by 2002:a17:902:9689:b029:d8:e310:2fa2 with SMTP id n9-20020a1709029689b02900d8e3102fa2mr2993033plp.42.1606200779869;
        Mon, 23 Nov 2020 22:52:59 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:2397])
        by smtp.gmail.com with ESMTPSA id m9sm13626703pfh.94.2020.11.23.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 22:52:59 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:52:57 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 5/7] bpf: Add BPF_FETCH field / create atomic_fetch_add
 instruction
Message-ID: <20201124065257.456bpoy4r5pf67xz@ast-mbp>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-6-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123173202.1335708-6-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 05:32:00PM +0000, Brendan Jackman wrote:
> @@ -3644,8 +3649,21 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>  		return err;
>  
>  	/* check whether we can write into the same memory */
> -	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> +			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	if (err)
> +		return err;
> +
> +	if (!(insn->imm & BPF_FETCH))
> +		return 0;
> +
> +	/* check and record load of old value into src reg  */
> +	err = check_reg_arg(env, insn->src_reg, DST_OP);
> +	if (err)
> +		return err;
> +	regs[insn->src_reg].type = SCALAR_VALUE;

check_reg_arg() will call mark_reg_unknown() which will set type to SCALAR_VALUE.
What is the point of another assignment?
