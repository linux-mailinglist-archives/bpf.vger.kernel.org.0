Return-Path: <bpf+bounces-10215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4D7A33CE
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 07:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091F31C208CC
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 05:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E4139E;
	Sun, 17 Sep 2023 05:25:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0E136F
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 05:25:44 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72F19F;
	Sat, 16 Sep 2023 22:25:42 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7926b7f8636so86497139f.1;
        Sat, 16 Sep 2023 22:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928341; x=1695533141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twT78nt1rfxez7OPRPN6+pMXVd42yQ1QRG5oqcjd3zE=;
        b=EtPFZUCOopkmgEdSj1XnMZBkp+MeNansuustY5TyfF/D1LCyulIJK27LhJUaZ2Yu93
         HKhAMHpt/btV6XQzv6917VJsoqYxQeKXVp7Uc9NnnhPNpSWEpAMA0XZ+aXnwQKh0qtsS
         a/mUE0nc9BWud0PXtwRYnq4nPCQ47tr/INghAS2Exi6ySYrKsOdB0DI1s3ZNe57oAO88
         v6tnmThnDTTF8vbxqCwtY+Rsq9iP+RmVMVl9c231e9zK9WwlkD1doYaE3xJ9/o+kCFF9
         biQGT91eojLawcEskjYbNXUakfB7c1n9criNbW8WBB20L4xAqGl6kijbdCOkCeYCDDH9
         SeaA==
X-Gm-Message-State: AOJu0YxC5wH0DkSAv7c7jxYjccZCh1AdNiQW4btlJlBeAtelxdjegobM
	IC+HMlDwaJ+GyJbkJBcd2hKN6XedUss7AP3SHPI=
X-Google-Smtp-Source: AGHT+IHlaCTeDSEP4js0QBlMkKkNpy2O81Q7bSvX0OTp2hKSKiDjdUDJY9oqpYigxqI2JvHNIUCYcAA0dpdMrDwQA2c=
X-Received: by 2002:a5d:9ac2:0:b0:785:d5d4:9f26 with SMTP id
 x2-20020a5d9ac2000000b00785d5d49f26mr6284970ion.9.1694928341169; Sat, 16 Sep
 2023 22:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913184534.227961-1-irogers@google.com>
In-Reply-To: <20230913184534.227961-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 16 Sep 2023 22:25:28 -0700
Message-ID: <CAM9d7cjX_d9sEbB=Zz2+Rw4YQqZsNPiwVVExg17nQSS_0oqUBw@mail.gmail.com>
Subject: Re: [PATCH v1] perf bpf-prologue: Remove unused file
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 13, 2023 at 11:45=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Commit 3d6dfae88917 ("perf parse-events: Remove BPF event support")
> removed building bpf-prologue.c but failed to remove the actual file.
>
> Fixes: 3d6dfae88917 ("perf parse-events: Remove BPF event support")
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools, thanks!

Namhyung

