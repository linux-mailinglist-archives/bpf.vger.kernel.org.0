Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7C149656
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2020 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgAYPqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 10:46:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38585 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAYPqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 10:46:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so5275313qki.5;
        Sat, 25 Jan 2020 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+rsTFtANefU15x1tLvfubQYWG4enVCsu0fAmTTJEk8=;
        b=hjFVu238uZdKEBOqIzCcVW9AiHvivoFn/Uof6vAI9uniIHD9y13PezHdl2lQSiTGLd
         tkTz5LUB7n/0IIrwEOV5S33TPcFxd7RlF6I2Y+u6Klu3v71TaUjBQs4o+Vt9M0IP7Kno
         2qdP7xrOwgDpcxHVB2ShQ4HiXNRF6erRN1CvJSPfIR1I8klaM8HMTotpLFiyOD3gfetI
         k3ZP11T+jGh0vYWY96v52CWaMHOkMJr6hkUcg6H+I/3fC1GRcbdaBRyRSa2gtd/sWKDp
         sdXv2oIeTavRMo538TNtgV4OJHLRZuyWq6mvW2sjJ/TNyA7dhDmH/iGvzShc+7U5SBTA
         QjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+rsTFtANefU15x1tLvfubQYWG4enVCsu0fAmTTJEk8=;
        b=F4zVTiIM0NjKZeHXmseydhgdLgZPDwWA1/Q/XRyynnKxZbUUaUGUj8ChgsOoLa7YtH
         /k3KADp7aL9Az40yAhBH78syjRhEv90VDmAPtfJb7qHMGmCDVb80/k2ydjW2ZZ0+cdjc
         ZiipWaS0psQjiTEOIG3Tk9IajM4innDxRR1HhQtjXZ8VqZPOw2kJjpOuF9Zw+R3sIYlA
         zWMuGs+TEstlzP0QkHhRZJAEirfz/EswkjzXR3YzQZmp3l7oP65GI0foaj7yB0CQwNpp
         w655rcBP6Gq//oya6+7k3s7cUzFRo6PC9OzwCN44F6Ky1cvC1kKJIbF1KGcGaMZjjJBx
         oj8g==
X-Gm-Message-State: APjAAAU6MpErrLgru7OqbuTJ1kYVFzFaWgxr+5kOwzbeNocnd4TSNAd/
        JnjJYbN25Rl9OvuffbDyuhASaa2lKTo=
X-Google-Smtp-Source: APXvYqyi/kWJkeCiN0iFNqBdhdDCEhO3ZGWnSXD7V0u1rbTWv7u2Oj4VzuXyEJPSzprURQWdgWGZQA==
X-Received: by 2002:a37:7745:: with SMTP id s66mr8320708qkc.125.1579967196029;
        Sat, 25 Jan 2020 07:46:36 -0800 (PST)
Received: from ast-mbp ([2620:10d:c091:480::c331])
        by smtp.gmail.com with ESMTPSA id v80sm2207403qka.15.2020.01.25.07.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 07:46:35 -0800 (PST)
Date:   Sat, 25 Jan 2020 07:46:30 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Message-ID: <20200125154628.3wiaqym45ltmxcu5@ast-mbp>
References: <20200124211705.24759-1-dxu@dxuuu.xyz>
 <20200124211705.24759-2-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124211705.24759-2-dxu@dxuuu.xyz>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 24, 2020 at 01:17:03PM -0800, Daniel Xu wrote:
> + *
> + * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size, u64 flags)
> + *	Description
> + *		For an eBPF program attached to a perf event, retrieve the
> + *		branch records (struct perf_branch_entry) associated to *ctx*
> + *		and store it in	the buffer pointed by *buf* up to size
> + *		*buf_size* bytes.
> + *
> + *		The *flags* can be set to **BPF_F_GET_BR_SIZE** to instead
> + *		return the number of bytes required to store all the branch
> + *		entries. If this flag is set, *buf* may be NULL.
> + *	Return
> + *		On success, number of bytes written to *buf*. On error, a
> + *		negative value.
> + *
> + *		**-EINVAL** if arguments invalid or **buf_size** not a multiple
> + *		of sizeof(struct perf_branch_entry).
> + *
> + *		**-ENOENT** if architecture does not support branch records.

the patches look good, but I'm struggling to decode the names.
perf_prog_read_branches... perf_prog means that it's for bpf prog that is of
'perf' type? I don't think any other helper has such prefix.
read branches... branches? they are branch records or branch entries.
How about bpf_read_branch_records() ?

I think BPF_F_GET_BR_SIZE is too cryptic.
How about BPF_F_GET_BRANCH_RECORDS_SIZE ?
