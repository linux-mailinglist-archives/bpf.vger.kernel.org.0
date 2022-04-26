Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B55107CE
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiDZTCx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347844AbiDZTCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 15:02:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA219915A
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:59:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so2948703pjb.4
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RwrzLtX0PA1aOkiN1wX+W89MRpEvwF7KUaC2rSeFQEc=;
        b=GAq4sPOBbbyQ2hRjYQ1CefxwPIThn98p6isbzHrWwXcomzW2Hga5so4FOe5LW1RvGm
         56RP6xkeV9+1rD2eNrsvN6E0TnLJATzdVOfkQD2OC59nTP5qGO6F3MZu2fWURwJRWkHA
         Eh4SGou+xO4o4oA1oZlPK1F8UpE/vxFv7DWGUN05CZd3pAk+Fe5BGT6h0mKjQHZrVi38
         UfwwaZRE7IYXCCUQRaelDEARG9/RQJqWV4liIE75YZNDI5G3BibYNCChkPjgFEj8ELgU
         Mqu5d9Ty3p37zmSif3+7D7KbxAAMKPlWQdJtdTSj7uYnkmKXAhMkv1sC2oo3EadLjT6d
         oIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RwrzLtX0PA1aOkiN1wX+W89MRpEvwF7KUaC2rSeFQEc=;
        b=d6gKy9iXuM4Myg0NaYbm98Ff6Ik08lnAoHTwbiF9ygQYyVU1lvTTdUKf3p5JbCTq74
         TANJDelAcIzO45W0T5oWQstPDA07jScQYiMoHWCXNexxethV2p4NxelusXYUDl5Nfs6K
         Oqg4TjJ4lF8XXTQFr0JJq60D7NqDNYzFRhCtplClEQkq3CBYc4SRdWRtEu1bBh6ZmYVf
         ZMDmd/puFE8QTUyHz99AvgqGO7o36wPslEub1CWjA2tiG45SaQlqbqAv3dsdpRzwSYly
         1KGWEZmvx+EaZZXIZEFarmKbO6Qiabf7rxZXKMzzm/xMEViyW2zuYC3AyBTrZFN6A34H
         ZOXA==
X-Gm-Message-State: AOAM531rY2JJiC72vn5Kp0SNcusUvoAjxS3JdbszTwPz5yROKOP8OSLo
        5SV0tqVf6wlsjCSgDml+oRo=
X-Google-Smtp-Source: ABdhPJzOQ7X6MXf5dNVmi832lxfJ+Wd881fGKGEksD4tHLjalSBpCu39elHX0UQFpEiw8lCXtNMGlg==
X-Received: by 2002:a17:90a:8581:b0:1b2:7541:af6c with SMTP id m1-20020a17090a858100b001b27541af6cmr28554588pjn.48.1650999580803;
        Tue, 26 Apr 2022 11:59:40 -0700 (PDT)
Received: from MacBook-Pro.local ([2620:10d:c090:500::2:3e5a])
        by smtp.gmail.com with ESMTPSA id p4-20020a637404000000b00375948e63d6sm13387280pgc.91.2022.04.26.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:59:40 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:59:38 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 09/10] libbpf: fix up verifier log for unguarded
 failed CO-RE relos
Message-ID: <20220426185938.klfmm6qmwad7o7qr@MacBook-Pro.local>
References: <20220426004511.2691730-1-andrii@kernel.org>
 <20220426004511.2691730-10-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426004511.2691730-10-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 25, 2022 at 05:45:10PM -0700, Andrii Nakryiko wrote:
> Teach libbpf to post-process BPF verifier log on BPF program load
> failure and detect known error patterns to provide user with more
> context.
> 
> Currently there is one such common situation: an "unguarded" failed BPF
> CO-RE relocation. While failing CO-RE relocation is expected, it is
> expected to be property guarded in BPF code such that BPF verifier
> always eliminates BPF instructions corresponding to such failed CO-RE
> relos as dead code. In cases when user failed to take such precautions,
> BPF verifier provides the best log it can:
> 
>   123: (85) call unknown#195896080
>   invalid func unknown#195896080
> 
> Such incomprehensible log error is due to libbpf "poisoning" BPF
> instruction that corresponds to failed CO-RE relocation by replacing it
> with invalid `call 0xbad2310` instruction (195896080 == 0xbad2310 reads
> "bad relo" if you squint hard enough).
> 
> Luckily, libbpf has all the necessary information to look up CO-RE
> relocation that failed and provide more human-readable description of
> what's going on:
> 
>   5: <invalid CO-RE relocation>
>   failed to resolve CO-RE relocation <byte_off> [6] struct task_struct___bad.fake_field_subprog (0:2 @ offset 8)
> 
> This hopefully makes it much easier to understand what's wrong with
> user's BPF program without googling magic constants.
> 
> This BPF verifier log fixup is setup to be extensible and is going to be
> used for at least one other upcoming feature of libbpf in follow up patches.
> Libbpf is parsing lines of BPF verifier log starting from the very end.
> Currently it processes up to 10 lines of code looking for familiar
> patterns. This avoids wasting lots of CPU processing huge verifier logs
> (especially for log_level=2 verbosity level). Actual verification error
> should normally be found in last few lines, so this should work
> reliably.
> 
> If libbpf needs to expand log beyond available log_buf_size, it
> truncates the end of the verifier log. Given verifier log normally ends
> with something like:
> 
>   processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> 
> ... truncating this on program load error isn't too bad (end user can
> always increase log size, if it needs to get complete log).

and it didn't break test_verifier?
In do_test_single() it does:
  proc = strstr(bpf_vlog, "processed ");
  insn_processed = atoi(proc + 10);
  if (test->insn_processed != insn_processed) {
