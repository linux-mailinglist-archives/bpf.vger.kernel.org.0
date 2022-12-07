Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE3645F37
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 17:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLGQtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 11:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLGQtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 11:49:05 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD72AE21
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 08:49:04 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1981394pjs.4
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5e1EQunVSwU15vK/Qq/lD18D6hfGYNxaGuqOV3UxeJQ=;
        b=B4LYZ0MPzxoqTq1/ymlXPP4x9cWYcRFGJSlqh1bGORPJeS9zwglHr0hrrMObMpgeoo
         Uo6XYXvVk7Lbe85qMiE5eu+dxxAaP2VQdUTLNBoYrbPeOaBKQFecs0rBbUsic6cxhFeF
         Xg2cWoo0dxzkNxo4W6ZJ6dQF8FYL+vIpyxU+jjMSiuP9lGBE3kho+WNpWebR5MI8n4Mj
         vPSnK5fBCt+jRgw2TmcazB3+Bx3KJjdbTvsT1Re3s/7czHflESZNZoDSgNCM1F5Q/slr
         Fdhhp2nqxMKd4IScD4WlqTwqTXySvKdcrMvElLu8SforGBSs6aH4B4QQyfWyoGzqZRLC
         bDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e1EQunVSwU15vK/Qq/lD18D6hfGYNxaGuqOV3UxeJQ=;
        b=fk2wKi8d54GChTh/S8SVLqXpKHnnKVhYQ6hRczH5cHcsiLmCzK7ITQBzZ/8FH9cyIB
         muuo5PE9GTkVFDgU+hGVR+LJ69nkCOARr1gClCOjTi8T8knEzZZ8lAr6xYslQkfacUTL
         YDpkhisG1As1aQjBzd2/LQ60hKRg738HecuTB749Y3bmkzAZvzdtuzHbCZFjLhkm3tF2
         CZ1VdZqJcYL1Ra6YcLUxdjST7oUJYOK5aDNdjNW1ryNJ5J2HUTLUlusHlcX4OLIW2HQO
         QlM8QIWb52vrqfbDLwdJDFbjBx/HB46yGbCLEu6cCKBVkPIvcj+iQBHlhZRhMhCZKlZP
         RXpw==
X-Gm-Message-State: ANoB5pncHAHHlpsC9vEA+eN5QGgp3aRJ4ShsmJYHcSLTLt4HwqZpbs8O
        xnnrgpDGvfoqvYY/ewKCLwInigHEv9lAVHne
X-Google-Smtp-Source: AA0mqf6Dnul4liNxqIOQZzCX1rw6JGvYuxCAQxdZBg3inhU+q5DZmzKsJGCfFVLNfneJxYmYBXtjtw==
X-Received: by 2002:a17:902:d58b:b0:189:cdc8:725a with SMTP id k11-20020a170902d58b00b00189cdc8725amr18717111plh.160.1670431743737;
        Wed, 07 Dec 2022 08:49:03 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b00186881e1feasm14781857pla.112.2022.12.07.08.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 08:49:03 -0800 (PST)
Date:   Wed, 7 Dec 2022 22:19:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 02/13] bpf: map_check_btf should fail if
 btf_parse_fields fails
Message-ID: <20221207164900.mqxvvw4thxldg4vo@apollo>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-3-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-3-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 04:39:49AM IST, Dave Marchevsky wrote:
> map_check_btf calls btf_parse_fields to create a btf_record for its
> value_type. If there are no special fields in the value_type
> btf_parse_fields returns NULL, whereas if there special value_type
> fields but they are invalid in some way an error is returned.
>
> An example invalid state would be:
>
>   struct node_data {
>     struct bpf_rb_node node;
>     int data;
>   };
>
>   private(A) struct bpf_spin_lock glock;
>   private(A) struct bpf_list_head ghead __contains(node_data, node);
>
> groot should be invalid as its __contains tag points to a field with
> type != "bpf_list_node".
>
> Before this patch, such a scenario would result in btf_parse_fields
> returning an error ptr, subsequent !IS_ERR_OR_NULL check failing,
> and btf_check_and_fixup_fields returning 0, which would then be
> returned by map_check_btf.
>
> After this patch's changes, -EINVAL would be returned by map_check_btf
> and the map would correctly fail to load.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: aa3496accc41 ("bpf: Refactor kptr_off_tab into btf_record")
> ---
>  kernel/bpf/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..c3599a7902f0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1007,7 +1007,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  	map->record = btf_parse_fields(btf, value_type,
>  				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
>  				       map->value_size);
> -	if (!IS_ERR_OR_NULL(map->record)) {
> +	if (IS_ERR(map->record))
> +		return -EINVAL;
> +

I didn't do this on purpose, because of backward compatibility concerns. An
error has not been returned in earlier kernel versions during map creation time
and those fields acted like normal non-special regions, with errors on use of
helpers that act on those fields.

Especially that bpf_spin_lock and bpf_timer are part of the unified btf_record.

If we are doing such a change, then you should also drop the checks for IS_ERR
in verifier.c, since that shouldn't be possible anymore. But I think we need to
think carefully before changing this.

One possible example is: If we introduce bpf_foo in the future and program
already has that defined in map value, using it for some other purpose, with
different alignment and size, their map creation will start failing.
