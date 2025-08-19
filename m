Return-Path: <bpf+bounces-66038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA67B2CDD1
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F0F564A71
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850031E113;
	Tue, 19 Aug 2025 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A280hM+/"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D543169
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635336; cv=none; b=XLVvJeF3eRSaeCFuP3ODWgubF3jZRfP0pGDRytW3+aO6CSQmdNI6CjIqOUIz2tSU4FfoLU4FhH2GOnUszMWxvUc6JHhCrK5kfhy7oy2XWx+wjySy2/9Fa24/WMi7SkXFQQSnbmn/EkeIrYleZre6s2Obw476IL4F0DwRi5Tkgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635336; c=relaxed/simple;
	bh=wK3YhY4+3lTHh98GdBMxUr3XfTkaNOpQWVSlY78eT9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ioZ4SzXBNXabElzN6kpZl2Athu+JWI5apsk/BtGQvZKRM9xiLYzBO+z0TCryub09yQ+Tf7JoCVOTcUt3RgHIKzYosVtCOFl6zZ2WTRLNoj78iJIKL/Wj9WHYmtPnmC4d2W8JY4OS7sLyLTAXxkpYJNpmz/0FQxRJZ5Y7H+c5Mrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A280hM+/; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755635321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAopiF8dZ3zuj1vhkZjH8oqB8pGFDZFe8uogKHTUOSA=;
	b=A280hM+/+Cp5IvWAcBP03DyjcxMnbwLk/dosmmaVKAzGKWQw3VIfAiDwFrHyaZRqkFdMDi
	buMBmtbkF2TzTr5bAJUuuGfKGlVhbnoRobmHoUI+sb2RSKmu0to8P1klPJKkRrb2EW8TYO
	zTcPtGpx3eTw0hDcSoKFH9pOHbgjuaQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  Matt Bobrowski <mattbobrowski@google.com>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/14] sched: psi: refactor psi_trigger_create()
In-Reply-To: <CAJuCfpH5cSDGmwBfEmiXkShxxdTEuoRXrTKndNwTMMDUzX8f3A@mail.gmail.com>
	(Suren Baghdasaryan's message of "Mon, 18 Aug 2025 21:09:51 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-12-roman.gushchin@linux.dev>
	<CAJuCfpH5cSDGmwBfEmiXkShxxdTEuoRXrTKndNwTMMDUzX8f3A@mail.gmail.com>
Date: Tue, 19 Aug 2025 13:28:31 -0700
Message-ID: <87ikijys28.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Suren Baghdasaryan <surenb@google.com> writes:

> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Currently psi_trigger_create() does a lot of things:
>> parses the user text input, allocates and initializes
>> the psi_trigger structure and turns on the trigger.
>> It does it slightly different for two existing types
>> of psi_triggers: system-wide and cgroup-wide.
>>
>> In order to support a new type of psi triggers, which
>> will be owned by a bpf program and won't have a user's
>> text description, let's refactor psi_trigger_create().
>>
>> 1. Introduce psi_trigger_type enum:
>>    currently PSI_SYSTEM and PSI_CGROUP are valid values.
>> 2. Introduce psi_trigger_params structure to avoid passing
>>    a large number of parameters to psi_trigger_create().
>> 3. Move out the user's input parsing into the new
>>    psi_trigger_parse() helper.
>> 4. Move out the capabilities check into the new
>>    psi_file_privileged() helper.
>> 5. Stop relying on t->of for detecting trigger type.
>
> It's worth noting that this is a pure core refactoring without any
> functional change (hopefully :))

Added this to the commit log.

>
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  include/linux/psi.h       | 15 +++++--
>>  include/linux/psi_types.h | 33 ++++++++++++++-
>>  kernel/cgroup/cgroup.c    | 14 ++++++-
>>  kernel/sched/psi.c        | 87 +++++++++++++++++++++++++--------------
>>  4 files changed, 112 insertions(+), 37 deletions(-)
>>
>> diff --git a/include/linux/psi.h b/include/linux/psi.h
>> index e0745873e3f2..8178e998d94b 100644
>> --- a/include/linux/psi.h
>> +++ b/include/linux/psi.h
>> @@ -23,14 +23,23 @@ void psi_memstall_enter(unsigned long *flags);
>>  void psi_memstall_leave(unsigned long *flags);
>>
>>  int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res =
res);
>> -struct psi_trigger *psi_trigger_create(struct psi_group *group, char *b=
uf,
>> -                                      enum psi_res res, struct file *fi=
le,
>> -                                      struct kernfs_open_file *of);
>> +int psi_trigger_parse(struct psi_trigger_params *params, const char *bu=
f);
>> +struct psi_trigger *psi_trigger_create(struct psi_group *group,
>> +                               const struct psi_trigger_params *param);
>>  void psi_trigger_destroy(struct psi_trigger *t);
>>
>>  __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
>>                         poll_table *wait);
>>
>> +static inline bool psi_file_privileged(struct file *file)
>> +{
>> +       /*
>> +        * Checking the privilege here on file->f_cred implies that a pr=
ivileged user
>> +        * could open the file and delegate the write to an unprivileged=
 one.
>> +        */
>> +       return cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
>> +}
>> +
>>  #ifdef CONFIG_CGROUPS
>>  static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
>>  {
>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
>> index f1fd3a8044e0..cea54121d9b9 100644
>> --- a/include/linux/psi_types.h
>> +++ b/include/linux/psi_types.h
>> @@ -121,7 +121,38 @@ struct psi_window {
>>         u64 prev_growth;
>>  };
>>
>> +enum psi_trigger_type {
>> +       PSI_SYSTEM,
>> +       PSI_CGROUP,
>> +};
>> +
>> +struct psi_trigger_params {
>> +       /* Trigger type */
>> +       enum psi_trigger_type type;
>> +
>> +       /* Resources that workloads could be stalled on */
>
> I would describe this as "Resource to be monitored"

Fixed.

>
>> +       enum psi_res res;
>> +
>> +       /* True if all threads should be stalled to trigger */
>> +       bool full;
>> +
>> +       /* Threshold in us */
>> +       u32 threshold_us;
>> +
>> +       /* Window in us */
>> +       u32 window_us;
>> +
>> +       /* Privileged triggers are treated differently */
>> +       bool privileged;
>> +
>> +       /* Link to kernfs open file, only for PSI_CGROUP */
>> +       struct kernfs_open_file *of;
...
>>         t->event =3D 0;
>>         t->last_event_time =3D 0;
>> -       t->of =3D of;
>> -       if (!of)
>> +
>> +       switch (params->type) {
>> +       case PSI_SYSTEM:
>>                 init_waitqueue_head(&t->event_wait);
>
> I think t->of will be left uninitialized here. Let's set it to NULL
> please.

Ack.

Thanks!

