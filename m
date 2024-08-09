Return-Path: <bpf+bounces-36768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34CA94D033
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786C91F213FC
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34659194A4B;
	Fri,  9 Aug 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGD7QFqo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223619308F
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206576; cv=none; b=eR9BrRftW3SZFVQj/4WYYlNVWH/UQyJQnGNMGeeY3F8wZFvyMOnTMwsJ6ZqRrmLI7W/gfXawJYlmDkx/5dMA+QuPZ61Xn2ktW/xFzkW3o/KuPrR4UwlAsBJA2RaVr9Ld8yX8oTHeDHcsC8z2/k4tPXTXPUouXwph+er1yvNGjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206576; c=relaxed/simple;
	bh=gW3glhpUJA7/dpQ2kednQBzafuScotu1BGKEaFWivI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IQ8o0aQjzMTGAL1j6QGGdn2H1+a2rJjqrO4gpEBZWt4oG0xiBL70OMiG3Y2gTA8ONDf7W3y23Apzz81V4of2054R/eFsj1uLwZd+0gv6t/RH+uuKMy1gIw0MFY/qRewY4xLb3/NdBI657CY5LiqxAzLOoHRJ9k0cYPC9QbA/Hjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGD7QFqo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so5026057a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206573; x=1723811373; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYyfCPw1U2EWPqIB3/rhx9Iovlv3jVZIRl6UrCT+wcE=;
        b=GGD7QFqoKtlTH17iuE18rucja/oqscIXjeQn3YE4z2fgSaRoRuTeK/24aV0mhDMuBF
         nkH9LzPiDw0OhUl4pQ1VahY3ZYxadyIqFb/1iIhNmbYc8Qtv8zeIbTUQVQCk+6tSmmul
         TBhlatzyeNW4A3DHwnFDXGh+NA34IPhnGvq4scG3TIWrB098XQFn9DCu1bH2NrlQ8a7R
         eJ5P9PHoOnd3VO2xXpX6mvPdzCow3cTgfZBIeoWBUcBEEyUxUtKUZUjMjwdynVLfRizT
         MB1/sWwO8er96uFTu/mnOoLGLS0Jact9tp/b4xBdLgtP4PmDl7SAgaZDNEe8e3upMjha
         dqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206573; x=1723811373;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYyfCPw1U2EWPqIB3/rhx9Iovlv3jVZIRl6UrCT+wcE=;
        b=rddNQu3iVSnJGKjxQsTtGHtvqzEYcpvqjHu35X1nQ2pD5AgdbyFDQTvkluIcHGsssO
         veN8wFFudi1H3lJRyQT6zv518iW7dwgGAAtYh08VOwjuGEY2vwgV5OBfEPj5yvxeJ/Kp
         Q36XzvYP1Jf29p0Dx74KiUW5Y86UYZIkDPMXkq6k4ZXYqjC6khmWQTQTqNIJvqMTWyGq
         XQsNZv+Ue3Jxi9bxvN0JNqYNNEq0v0dbeX8fta9UVMRnnR//ZKXTK7+ejS+kn3mjWRyg
         zkW0tEVkz0kcxBM0GZgaXi1v32Hqe8dlKQTPSFTlhzJEWH2ZqnktNGe/qcV1Puvi/6zD
         VDag==
X-Gm-Message-State: AOJu0YxLlqkdnGZ65OxSU4+R87e8rlS+IolTXU+IqzHtXF5N2RYAQcfC
	tFWZExpld/g6nQzwqTQBrf25NOduNkpOP244sG4b9Z7boMfIVhcXjx9DQZ7r95fi2eSJv2WsMG7
	6
X-Google-Smtp-Source: AGHT+IG90znWYijgkVldbvLyX27hn7KQqBHZK18lzNyvMqR9t73Lk3dXTNuGj60TrKmuiVdGeQZywA==
X-Received: by 2002:a17:907:7f0f:b0:a7d:c382:bcdf with SMTP id a640c23a62f3a-a8091ef367cmr446713566b.10.1723206573367;
        Fri, 09 Aug 2024 05:29:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc423csm840685966b.26.2024.08.09.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:29:33 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:29:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Martin KaFai Lau <kafai@fb.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: libbpf: bpftool: Print bpf_line_info during prog
 dump
Message-ID: <623df9a4-6449-4e38-bf3a-1621597ee55d@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Martin KaFai Lau,

Commit b053b439b72a ("bpf: libbpf: bpftool: Print bpf_line_info
during prog dump") from Dec 7, 2018 (linux-next), leads to the
following Smatch static checker warning:

	./tools/bpf/bpftool/prog.c:827 prog_dump()
	error: we previously assumed 'ksyms' could be null (see line 793)

tools/bpf/bpftool/prog.c
    775                 if (info->nr_jited_func_lens && info->jited_func_lens) {
    776                         struct kernel_sym *sym = NULL;
    777                         struct bpf_func_info *record;
    778                         char sym_name[SYM_MAX_NAME];
    779                         unsigned char *img = buf;
    780                         __u64 *ksyms = NULL;
    781                         __u32 *lens;
    782                         __u32 i;
    783                         if (info->nr_jited_ksyms) {
    784                                 kernel_syms_load(&dd);
    785                                 ksyms = u64_to_ptr(info->jited_ksyms);
    786                         }

ksyms is NULL on else path

    787 
    788                         if (json_output)
    789                                 jsonw_start_array(json_wtr);
    790 
    791                         lens = u64_to_ptr(info->jited_func_lens);
    792                         for (i = 0; i < info->nr_jited_func_lens; i++) {
    793                                 if (ksyms) {
    794                                         sym = kernel_syms_search(&dd, ksyms[i]);
    795                                         if (sym)
    796                                                 sprintf(sym_name, "%s", sym->name);
    797                                         else
    798                                                 sprintf(sym_name, "0x%016llx", ksyms[i]);
    799                                 } else {
    800                                         strcpy(sym_name, "unknown");
    801                                 }
    802 
    803                                 if (func_info) {
    804                                         record = func_info + i * info->func_info_rec_size;
    805                                         btf_dumper_type_only(btf, record->type_id,
    806                                                              func_sig,
    807                                                              sizeof(func_sig));
    808                                 }
    809 
    810                                 if (json_output) {
    811                                         jsonw_start_object(json_wtr);
    812                                         if (func_info && func_sig[0] != '\0') {
    813                                                 jsonw_name(json_wtr, "proto");
    814                                                 jsonw_string(json_wtr, func_sig);
    815                                         }
    816                                         jsonw_name(json_wtr, "name");
    817                                         jsonw_string(json_wtr, sym_name);
    818                                         jsonw_name(json_wtr, "insns");
    819                                 } else {
    820                                         if (func_info && func_sig[0] != '\0')
    821                                                 printf("%s:\n", func_sig);
    822                                         printf("%s:\n", sym_name);
    823                                 }
    824 
    825                                 if (disasm_print_insn(img, lens[i], opcodes,
    826                                                       name, disasm_opt, btf,
--> 827                                                       prog_linfo, ksyms[i], i,
                                                                          ^^^^^^^^
Dereferenced

    828                                                       linum))
    829                                         goto exit_free;
    830 
    831                                 img += lens[i];
    832 
    833                                 if (json_output)
    834                                         jsonw_end_object(json_wtr);
    835                                 else
    836                                         printf("\n");
    837                         }
    838 
    839                         if (json_output)
    840                                 jsonw_end_array(json_wtr);
    841                 } else {
    842                         if (disasm_print_insn(buf, member_len, opcodes, name,
    843                                               disasm_opt, btf, NULL, 0, 0,
    844                                               false))
    845                                 goto exit_free;
    846                 }

regards,
dan carpenter

