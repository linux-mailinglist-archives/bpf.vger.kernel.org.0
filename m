Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36F20625A
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 23:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbgFWU7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390114AbgFWU7l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 16:59:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD95C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 13:59:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so94300ljc.8
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=TT2FZxgpjI3VkckydSkMTZ86IbhbF6gKg3r0vREiuvk=;
        b=m+WSj3btBtZQ/D6lseNcykWUPiFeFygNNYhSssoKxz+FopYF+OQrtacfrQKI7odjvK
         GvvCY2sAIPaL2PqhZBWLCdHEcWN0UxRSMRQ9GLAgKuNMgqflcjNgQNe4dXmz6LP2HOmG
         v0S/jglF4lP8Pp5PTd4K/PmrhQxhWF8yhGJy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=TT2FZxgpjI3VkckydSkMTZ86IbhbF6gKg3r0vREiuvk=;
        b=MuKpl8GfqoybR194JC6Q1hnx9mT8Axn0FUhT1repTaivRvLWVhaaz4MGQaJazrG7Ba
         j7eJ9r1Wu3lzr9wGu3CVmy5+/pRA51UBXRK+nQRhPAfa2ndUlejAkAxAKBbYy+wVirvT
         25BA6iYiqOsR5eilLcySKIZ0Fv8fgFs/0OBTiahtrPt76+5lzoUqTrryH3twLdI7kmrY
         Gm0lyNuOh9SvoepqVOpgWetC6fsbJFmcO4GvIEWrecYuQ62EWKXl8NtmnTxcRSYpWYk0
         5huJ0pRxSukztrs+RQkW1m4hI/fc3CnwJIl6tvFpFciCpSoJgvh3GKSXAwfXQo/jlclc
         t9Eg==
X-Gm-Message-State: AOAM533QUnOniLJpADBnnVJig8Y8n5OzfaFStzk4AtC0XDMUXaA7NASI
        V4SFpBhj2ReqBDoHmZaKPjBC3g==
X-Google-Smtp-Source: ABdhPJzVM7jBvlMi/1dIDGHjpIwo7Vb0q67nlm85VQ9OwQDLnc5UYl+TRxakJLLS1YEM9e+jS1BCZg==
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr12640870ljp.310.1592945979425;
        Tue, 23 Jun 2020 13:59:39 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id r15sm3518864ljm.31.2020.06.23.13.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 13:59:38 -0700 (PDT)
References: <20200623103459.697774-1-jakub@cloudflare.com> <20200623103459.697774-3-jakub@cloudflare.com> <20200623193352.4mdmfg4mfmgfeku4@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf, netns: Keep attached programs in bpf_prog_array
In-reply-to: <20200623193352.4mdmfg4mfmgfeku4@kafai-mbp.dhcp.thefacebook.com>
Date:   Tue, 23 Jun 2020 22:59:37 +0200
Message-ID: <87sgelmrba.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 09:33 PM CEST, Martin KaFai Lau wrote:
> On Tue, Jun 23, 2020 at 12:34:58PM +0200, Jakub Sitnicki wrote:
>
> [ ... ]
>
>> @@ -93,8 +108,16 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
>>  		goto out_unlock;
>>  	}
>>
>> +	run_array = rcu_dereference_protected(net->bpf.run_array[type],
>> +					      lockdep_is_held(&netns_bpf_mutex));
>> +	if (run_array)
>> +		ret = bpf_prog_array_replace_item(run_array, link->prog, new_prog);
>> +	else
> When will this happen?

This will never happen, unless there is a bug. As long as there is a
link attached, run_array should never be detached (null). Because it can
be handled gracefully, we fail the bpf(LINK_UPDATE) syscall.

Your question makes me think that perhaps it should trigger a warning,
with WARN_ON_ONCE, to signal clearly to the reader that this is an
unexpected state.

WDYT?

>
>> +		ret = -ENOENT;
>> +	if (ret)
>> +		goto out_unlock;
>> +
>>  	old_prog = xchg(&link->prog, new_prog);
>> -	rcu_assign_pointer(net->bpf.progs[type], new_prog);
>>  	bpf_prog_put(old_prog);
>>
>>  out_unlock:
>> @@ -142,14 +165,38 @@ static const struct bpf_link_ops bpf_netns_link_ops = {
>>  	.show_fdinfo = bpf_netns_link_show_fdinfo,
>>  };
