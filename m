Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5766C2322A9
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgG2Q1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgG2Q1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 12:27:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390FFC0619D2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 09:27:54 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f1so5376828qvx.13
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MGpr77ldP86j3ZNZw4dToP4I3Kuuvh6wpixf0WTOZ7A=;
        b=E5s1JzzxuTppaPhCGoUOcD/A2Te/6/+hf8galBXKlXdygJo6jWW528Da7QGtjB4Lok
         +PmpIcj0xgO6gLvxk4RVwNjC3KPGwtlg1bDESFJ/AlJ786VwQhSkb0QAsl0fBd1eP8a5
         Im65W+SvjvzmSIlT3GWGB4BuECXxt9QTxuvDkA8lXgVqIygGncTiUda96AxF2IPwBOca
         i8imwVjqoXOjZRSzeGEozmhDauvSHlnZQQ9DYl7SzyLEnVVZTOloW2M00mhaklg9IQa+
         PvnfuArqeQPiIX+IoCk5hIBHmby5C+c1TA0oEQXGlujkUWb1/0tAlg+7FOSKCmHmbzFU
         Fw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MGpr77ldP86j3ZNZw4dToP4I3Kuuvh6wpixf0WTOZ7A=;
        b=r0eU7qu504c+f1buae00dOAoESsK9cRuXkxn7cmGHpI2Bh9R+4i/May49aaiSHxz9Q
         4OKQ89UdxalA+30dweJ4oK2O3BDV0MXs9NGoDoK88z1+Z4szMGLCn/5ZVZfFvUtL/O3b
         IARmnD2GjnNMSPtApuXh2PBGCG8ivCEGaLQXk0bfwI9G9NqMb4FG/+JrG4eME4QdZ6td
         SdGh+4JTMzr1k0sCirOg7jmjLm0b6dcEnvClAvyPOAQpwOOABudYylFvXuF8LMcv6q6K
         adMzPYwEcSlxX71RsP9eccN5FJxBj+bWFIFFkOS1XOS0Rmyd9P5BuZlhT6G5zRGc7yRI
         XWIQ==
X-Gm-Message-State: AOAM532Pu7zOaB5Fbflfq2MO5YETouvkAVrAu3++3gliBTq5ZKsL5hvD
        ija59BHh26UnbsIzs4Pb6dX/ZZKynXSsvHzmwLa3rEDXN6QQjx8hrvddD6WUZOqeeZ47lhhk1xP
        1C4nU7GHmXdt13tUJcNQIyu0TAOAop+qlzdw0PRiektFmW+emEw==
X-Google-Smtp-Source: ABdhPJzDo8uewqT+OsGuX8gLdD0M+nm4VGbeFMjZ0bsv9tKp17jw4CUB1TB8AgnI6Y59g4wmjd4aAmg=
X-Received: by 2002:ad4:5042:: with SMTP id m2mr32830843qvq.225.1596040073246;
 Wed, 29 Jul 2020 09:27:53 -0700 (PDT)
Date:   Wed, 29 Jul 2020 09:27:51 -0700
Message-Id: <20200729162751.GC184844@google.com>
Mime-Version: 1.0
Subject: BPF program metadata
From:   sdf@google.com
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com,
        zhuyifei@google.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As discussed in
https://docs.google.com/presentation/d/1A9Anx8JPHl_pK1aXy8hlxs3V5pkrKwHHtkPf_-HeYTc
during BPF office hours, we'd like to attach arbitrary auxiliary
metadata to the program, for example, the build timestamp or the commit
hash.

IIRC, the suggestion was to explore BTF and .BTF.ext section in
particular.
We've spent some time looking at the BTF encoding and BTF.ext section
and we don't see how we can put this data into .BTF.ext or even .BTF
without any kernel changes.

The reasoning (at least how we see it):
* .BTF.ext is just a container with func_info/line_info/relocation_info
   and libbpf extracts the data form this section and passes it to
   sys_bpf(BPF_PROG_LOAD); the important note is that it doesn't pass the
   whole container to the kernel, but passes the data that's been
   extracted from the appropriate sections
* .BTF can be used for metadata, but it looks like we'd have to add
   another BTF_INFO_KIND() to make it a less messy (YiFei, feel free to
   correct me)

So the question is: are we missing something? Is there some way to add
key=value metadata to BTF that doesn't involve a lot of kernel changes?

If the restrictions above are correct, should we go back to trying to
put this metadata into .data section (or maybe even the new .metadata
section)? The only missing piece of the puzzle in that case is the
ability to extend BPF_PROG_LOAD with a way to say 'hold this map
unconditionally'.
