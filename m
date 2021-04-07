Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8A93562A7
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 06:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhDGEuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 00:50:05 -0400
Received: from wforward3-smtp.messagingengine.com ([64.147.123.22]:40201 "EHLO
        wforward3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229825AbhDGEuF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Apr 2021 00:50:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.west.internal (Postfix) with ESMTP id 7AAD01555;
        Wed,  7 Apr 2021 00:49:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Apr 2021 00:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=GOL+J7Dq1+NRvbGHBj0dtiObWzKNWDOC0Rl9g4fdk
        q8=; b=OkbYJG3r4l18lUV09uuF6c1DhKrKJ70FXT/KclQstI/vZ5B3iWLDDraLf
        grnYMmH/brjNKC1gTmHCeiw5E4Tr1DQdb7NJhdI91wu5Po6u17G723DzlMpda6V9
        fAKbxHLiLB9gyFglu881zy+7nl4oCYs795vrGY5U7MABSHE30E+uAoTyT83hukxy
        GMDRNpahn5S4Bk0AI5BWkOVeZoAyu2pfcIVLN5hU0o8j0sfmwLa/nJsRRiQ2odES
        MSrq4un477VlTw5pnvBvlzLlOyBpv98YwPso0BO2EeHMeWKOJ14+XoccmL8unN39
        4JOidrkDUzhc4il+yyJDsZjp7wofQ==
X-ME-Sender: <xms:8zltYIaV27-CenzOVWRBgonPUaH5k7DVLv_pmFmjeaaepvQZeMInRA>
    <xme:8zltYDYqU0zeAMMhrBG9tTk3DNFoqvz5X4z9uqRtmQjDpOs7al9DZzlGziWaoig6f
    BX-PnYPHRCV8snxfrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejiedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthekmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhepfeegueelkeeiteettdfhjeevgfehgeek
    vedtvdekveejgfejjedvfeejleehjeffnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dpkhgvrhhnvghlrdhorhhgnecukfhppedukeehrdduheefrddujeeirdekjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhguth
    hinhhotghosehusghunhhtuhdrtghomh
X-ME-Proxy: <xmx:8zltYC_Vfey_lIf0qCdFYwIiJwoiuBSiDAbYymO5bdWTklnr2__zmg>
    <xmx:8zltYCprU02SxQERL8g98ppMYHLFzg9LM3ssjasF_5l-ufESvFCRww>
    <xmx:8zltYDohyFHIcQd4QI6yTAsA0-sD5q12Z1dmkhUMn27SkxzNntfXRQ>
    <xmx:9DltYA3r2n_UIsncTUZlOwkZKHVKTTuWbnDMkTviO7U9VT99eMZ-Rq2Kp04>
Received: from [10.6.2.35] (unknown [185.153.176.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C7B1108005F;
        Wed,  7 Apr 2021 00:49:55 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events
 support
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
Date:   Wed, 7 Apr 2021 01:49:53 -0300
Cc:     LKML BPF <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 639463793.548651-328f7d899a128d525f69dcd92a0be8f4
Content-Transfer-Encoding: 8bit
Message-Id: <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com>
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
 <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry taking so long for replying on this… have been working in:
https://github.com/rafaeldtinoco/conntracker/tree/main/ebpf
as a consumer for the work being proposed by this patch.

Current working version at:
https://github.com/rafaeldtinoco/conntracker/blob/main/ebpf/patches/libbpf-introduce-legacy-kprobe-events-support.patch
About to be changed with suggestions from this thread.

>>> --- a/src/libbpf.c
>>> +++ b/src/libbpf.c
>>> @@ -9465,6 +9465,10 @@ struct bpf_link {
>>>       char *pin_path;         /* NULL, if not pinned */
>>>       int fd;                 /* hook FD, -1 if not applicable */
>>>       bool disconnected;
>>> +     struct {
>>> +             const char *name;
>>> +             bool retprobe;
>>> +     } legacy;
>>>  };
>>
>> For bpf_link->detach() I needed func_name somewhere.
>
> Right, though it's not func_name that you need, but "event_name".

Yep.

> Let's add link ([0]) to poke_kprobe_events somewhere, and probably
> event have example full syntax of all the commands:
>
>  p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]  : Set a probe
>  r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]  : Set a return probe
>  p:[GRP/]EVENT] [MOD:]SYM[+0]%return [FETCHARGS]       : Set a return probe
>  -:[GRP/]EVENT                                         : Clear a probe
>
>   [0] https://www.kernel.org/doc/html/latest/trace/kprobetrace.html

Add [0] as a comment you say (as a reference) ? Or you mean to alter
the way I’m writing to kprobe_events file in a more complete way ?

> Now, you should not extend bpf_link itself. Create bpf_link_kprobe,
> that will have those two extra fields. Put struct bpf_link as a first
> field of bpf_link_kprobe. We used to have bpf_link_fd, you can try to
> find it in Git history to see how it was done.

Will do.

> And another problem -- you should allocate memory for this event_name,
> not rely on the user to keep that memory for you.

Definitely.

>>> +
>>> +#define KPROBE_PERF_TYPE     "/sys/bus/event_source/devices/kprobe/type"
>>> +#define UPROBE_PERF_TYPE     "/sys/bus/event_source/devices/uprobe/type"
>>> +#define KPROBERET_FORMAT
>>> "/sys/bus/event_source/devices/kprobe/format/retprobe"
>>> +#define UPROBERET_FORMAT
>>> "/sys/bus/event_source/devices/uprobe/format/retprobe"
>>> +/* legacy kprobe events related files */
>>> +#define KPROBE_EVENTS                 
>>> "/sys/kernel/debug/tracing/kprobe_events"
>>> +#define KPROBE_LEG_TOGGLE    "/sys/kernel/debug/kprobes/enabled"
>
> Not LEG, please, LEGACY

I’m removing all those like you said, not much advantage in going back
and forth because of those definitions.

>
>>> +#define KPROBE_LEG_ALL_TOGGLE
>>> "/sys/kernel/debug/tracing/events/kprobes/enable";
>>> +#define KPROBE_SINGLE_TOGGLE
>>> "/sys/kernel/debug/tracing/events/kprobes/%s/enable";
>>> +#define KPROBE_EVENT_ID       
>>> "/sys/kernel/debug/tracing/events/kprobes/%s/id";
>>> +
>>
>> This made the life easier: to understand which files were related to what
>
> Ok, sure, just not legs, please :)
>
>>> +static bool determine_kprobe_legacy(void)
>>> +{
>>> +     struct stat s;
>>> +
>>> +     return stat(KPROBE_PERF_TYPE, &s) == 0 ? false : true;
>
> there is access(file, F_OK) which is nicer to use for checking file  
> existence

Sure.

>>> +static int toggle_kprobe_legacy(bool on)
>>> +{
>>> +     static int refcount;
>>> +     static bool initial, veryfirst;
>>> +     const char *file = KPROBE_LEG_TOGGLE;
>>> +
>>> +     if (on) {
>>> +             refcount++;
>>> +             if (veryfirst)
>>> +                     return 0;
>>> +             veryfirst = true;
>>> +             /* initial value for KPROB_LEG_TOGGLE */
>>> +             initial = (bool) parse_uint_from_file(file, "%d\n");
>>> +             return write_uint_to_file(file, 1); /* enable kprobes */
>>> +     }
>>> +     refcount--;
>>> +     printf("DEBUG: kprobe_legacy refcount=%d\n", refcount);
>>> +     if (refcount == 0) {
>>> +             /* off ret value back to initial value if last consumer */
>>> +             return write_uint_to_file(file, initial);
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int toggle_kprobe_event_legacy_all(bool on)
>>> +{
>>> +     static int refcount;
>>> +     static bool initial, veryfirst;
>>> +     const char *file = KPROBE_LEG_ALL_TOGGLE;
>>> +
>>> +     if (on) {
>>> +             refcount++;
>>> +             if (veryfirst)
>>> +                     return 0;
>>> +             veryfirst = true;
>>> +             // initial value for KPROB_LEG_ALL_TOGGLE
>>> +             initial = (bool) parse_uint_from_file(file, "%d\n");
>>> +             return write_uint_to_file(file, 1); // enable kprobes
>>> +     }
>>> +     refcount--;
>>> +     printf("DEBUG: legacy_all refcount=%d\n", refcount);
>>> +     if (refcount == 0) {
>>> +             // off ret value back to initial value if last consumer
>>> +             return write_uint_to_file(file, initial);
>>> +     }
>>> +     return 0;
>>> +}
>>
>> Same thing here: 2 functions that could be reduced to one with an
>> argument to KPROB_LEG_TOGGLE or KPROB_LEG_ALL_TOGGLE.
>>
>> I’m using static initial so I can recover the original status of
>> the “enable” files after the program is unloaded. Unfortunately
>> this is not multi-task friendly as another process would
>> step into this logic but I did not want to leave “enabled”
>> after we unload if it wasn’t before.
>>
>> I’m saying this because of your idea of having PID as the kprobe
>> event names… it would have the same problem… We could, in theory
>> leave all “enabled” files enabled (1) at the end, use PID in the
>> kprobe event names and unload only our events… but then I would
>> leave /sys/kernel/debug/kprobes/enabled enabled even if it was
>> not.. because we could be concurrent to other tasks using libbpf.
>
> So I don't get at all why you have these toggles, especially
> ALL_TOGGLE? You shouldn't try to determine the state of another probe.
> You always know whether you want to enable or disable your specific
> toggle. I'm very confused by all this.

Yes, this was a confusing thing indeed and to be honest it proved to
be very buggy when testing with conntracker. What I’ll do (or I’m
doing) is to toggle ON to needed files before the probe is added:

static inline int add_kprobe_event_legacy(const char* func_name, bool  
retprobe)
{
	int ret = 0;

	ret |= poke_kprobe_events(true, func_name, retprobe);
	ret |= toggle_kprobe_event_legacy_all(true);
	ret |= toggle_single_kprobe_event_legacy(true, func_name, retprobe);

	return ret;
}

1) /sys/kernel/debug/tracing/kprobe_events => 1
2) /sys/kernel/debug/tracing/events/kprobes/enable => 1
3) /sys/kernel/debug/tracing/events/kprobes/%s/enable => 1

And toggle off only kprobe_event:

static inline int remove_kprobe_event_legacy(const char* func_name, bool  
retprobe)
{
	int ret = 0;

	ret |= toggle_single_kprobe_event_legacy(false, func_name, retprobe);
	ret |= poke_kprobe_events(false, func_name, retprobe);

	return ret;
}

1) /sys/kernel/debug/tracing/events/kprobes/%s/enable => 0

This is working good for my tests.

>
>>> +static int kprobe_event_normalize(char *newname, size_t size, const char
>>> *name, bool retprobe)
>>> +{
>>> +     int ret = 0;
>>> +
>>> +     if (IS_ERR(name))
>>> +             return -1;
>>> +
>>> +     if (retprobe)
>>> +             ret = snprintf(newname, size, "kprobes/%s_ret", name);
>>> +     else
>>> +             ret = snprintf(newname, size, "kprobes/%s", name);
>>> +
>>> +     if (ret <= strlen("kprobes/"))
>>> +             ret = -errno;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int toggle_single_kprobe_event_legacy(bool on, const char *name,
>>> bool retprobe)
>
> don't get why you need this function either...

Because of /sys/kernel/debug/tracing/events/kprobes/%s/enable. I’m
toggling it to OFF before removing the kprobe in kprobe_events, like
showed above.

>
>>> +{
>>> +     char probename[32], f[96];
>>> +     const char *file = KPROBE_SINGLE_TOGGLE;
>>> +     int ret;
>>> +
>>> +     ret = kprobe_event_normalize(probename, sizeof(probename), name,
>>> retprobe);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     snprintf(f, sizeof(f), file, probename + strlen("kprobes/"));
>>> +
>>> +     printf("DEBUG: writing %u to %s\n", (unsigned int) on, f);
>>> +
>>> +     ret = write_uint_to_file(f, (unsigned int) on);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int poke_kprobe_events(bool add, const char *name, bool retprobe)
>>> +{
>>> +     int fd, ret = 0;
>>> +     char probename[32], cmd[96];
>>> +     const char *file = KPROBE_EVENTS;
>>> +
>>> +     ret = kprobe_event_normalize(probename, sizeof(probename), name,
>>> retprobe);
>
> just have that if/else + snprintf right here, no need to jump through hoops
>

Sure.

>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     if (add)
>>> +             snprintf(cmd, sizeof(cmd),"%c:%s %s", retprobe ? 'r' : 'p',
>>> probename, name);
>>> +     else
>>> +             snprintf(cmd, sizeof(cmd), "-:%s", probename);
>>> +
>>> +     printf("DEBUG: %s\n", cmd);
>>> +
>>> +     fd = open(file, O_WRONLY|O_APPEND, 0);
>>> +     if (!fd)
>>> +             return -errno;
>>> +     ret = write(fd, cmd, strlen(cmd));
>>> +     if (ret < 0)
>>> +             ret = -errno;
>>> +     close(fd);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static inline int add_kprobe_event_legacy(const char* func_name, bool
>>> retprobe)
>>> +{
>>> +     int ret = 0;
>>> +
>>> +     ret = poke_kprobe_events(true, func_name, retprobe);
>>> +     if (ret < 0)
>>> +             printf("DEBUG: poke_kprobe_events (on) error\n");
>>> +
>>> +     ret = toggle_kprobe_event_legacy_all(true);
>
> why?... why do you need to touch the state of other probes. This will
> never work reliable but also should not be required

Addressed above.

>>> +     if (ret < 0)
>>> +             printf("DEBUG: toggle_kprobe_event_legacy_all (on)  
>>> error\n");
>>> +
>>> +     ret = toggle_single_kprobe_event_legacy(true, func_name, retprobe);
>>> +     if (ret < 0)
>>> +             printf("DEBUG: toggle_single_kprobe_event_legacy (on)  
>>> error\n");
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static inline int remove_kprobe_event_legacy(const char* func_name, bool
>>> retprobe)
>>> +{
>>> +     int ret = 0;
>>> +
>>> +     ret = toggle_kprobe_event_legacy_all(true);
>>> +     if (ret < 0)
>>> +             printf("DEBUG: toggle_kprobe_event_legacy_all (off)  
>>> error\n");
>>> +
>>> +     ret = toggle_single_kprobe_event_legacy(true, func_name, retprobe);
>>> +     if (ret < 0)
>>> +             printf("DEBUG: toggle_single_kprobe_event_legacy (off)  
>>> error\n");
>>> +
>>> +     ret = toggle_single_kprobe_event_legacy(false, func_name,  
>>> retprobe);
>>> +     if (ret < 0)
>>> +             printf("DEBUG: toggle_single_kprobe_event_legacy (off)  
>>> error\n");
>>> +
>>> +     ret = poke_kprobe_events(false, func_name, retprobe);
>>> +     if (ret < 0)
>>> +             printf("DEBUG: poke_kprobe_events (off) error\n");
>>> +
>>> +     return ret;
>>> +}
>>
>> I’m doing a “make sure what has to be enabled to be enabled” approach  
>> here.
>> Please ignore all the DEBUGs, etc, I’ll deal with errors after its good.
>
> again, you haven't explained why. Don't touch probes you haven't created.

Addressed above.

>
>>> +
>>> +static int determine_kprobe_perf_type_legacy(const char *func_name)
>>> +{
>>> +     char file[96];
>>> +     const char *fname = KPROBE_EVENT_ID;
>
> again, what's the point of this variable, just inline
>
> and this is a problem with those #defines. I need to now jump back and
> forth to see what KPROBE_EVENT_ID is. So unless we have to use them in
> multiple places, I'd keep those constants where they were, honestly.

Addressed above.
>

>>> +
>>> +     snprintf(file, sizeof(file), fname, func_name);
>>> +
>>> +     return parse_uint_from_file(file, "%d\n");
>>> +}
>>> +
>>>  static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>>>                                uint64_t offset, int pid)
>>>  {
>>> @@ -9760,6 +10034,51 @@ static int perf_event_open_probe(bool uprobe,
>>> bool retprobe, const char *name,
>>>       return pfd;
>>>  }
>>>
>>> +static int perf_event_open_probe_legacy(bool uprobe, bool retprobe,
>>> const char *name,
>>> +                                     uint64_t offset, int pid)
>>> +{
>>> +     struct perf_event_attr attr = {};
>>> +     char errmsg[STRERR_BUFSIZE];
>>> +     int type, pfd, err;
>>> +
>>> +     if (uprobe) // legacy uprobe not supported yet
>>> +             return -1;
>>
>> Would that be ok for now ? Until we are sure kprobe legacy interface is
>> good ?
>
> it's ok, but return -EOPNOTSUPP instead

Cool.

>>> +
>>> +     err = toggle_kprobe_legacy(true);
>>> +     if (err < 0) {
>>> +             pr_warn("failed to toggle kprobe legacy support: %s\n",
>>> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>>> +             return err;
>>> +     }
>>> +     err = add_kprobe_event_legacy(name, retprobe);
>>> +     if (err < 0) {
>>> +             pr_warn("failed to add legacy kprobe event: %s\n",
>>> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>>> +             return err;
>>> +     }
>>> +     type = determine_kprobe_perf_type_legacy(name);
>>> +     if (err < 0) {
>>> +             pr_warn("failed to determine legacy kprobe event id: %s\n",
>>> libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
>>> +             return type;
>>> +     }
>>> +
>>> +     attr.size = sizeof(attr);
>>> +     attr.config = type;
>>> +     attr.type = PERF_TYPE_TRACEPOINT;
>>> +
>>> +     pfd = syscall(__NR_perf_event_open,
>>> +                   &attr,
>>> +                   pid < 0 ? -1 : pid,
>>> +                   pid == -1 ? 0 : -1,
>>> +                   -1,
>>> +                   PERF_FLAG_FD_CLOEXEC);
>
> btw, a question. Is there similar legacy interface to tracepoints? It
> would be good to support those as well. Doesn't have to happen at the
> same time, but let's just keep it in mind as we implement this.

I *think* the current one is good enough for ~4.15, but I’ll test and
make sure to _at least_ document we need something else if we really
do.

>
>>> +
>>> +     if (pfd < 0) {
>>> +             err = -errno;
>>> +             pr_warn("legacy kprobe perf_event_open() failed: %s\n",
>>> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>>> +             return err;
>>> +     }
>>> +     return pfd;
>>> +}
>>> +
>>>  struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
>>>                                           bool retprobe,
>>>                                           const char *func_name)
>>> @@ -9788,6 +10107,33 @@ struct bpf_link
>>> *bpf_program__attach_kprobe(struct bpf_program *prog,
>>>       return link;
>>>  }
>>>
>>> +struct bpf_link *bpf_program__attach_kprobe_legacy(struct bpf_program
>
> this is wrong from the API perspective. The goal is to not make users
> decide whether they want legacy or non-legacy interfaces. With all
> your work there shouldn't be any new APIs.
> bpf_program__attach_kprobe() should detect which interface to use and
> just use it.

Yep, I failed to recognise it as an API symbol back when I did this.

>
>>> *prog,
>>> +                                                bool retprobe,
>>> +                                                const char *func_name)
>>> +{
>>> +     char errmsg[STRERR_BUFSIZE];
>>> +     struct bpf_link *link;
>>> +     int pfd, err;
>>> +
>>> +     pfd = perf_event_open_probe_legacy(false, retprobe, func_name, 0,  
>>> -1);
>>> +     if (pfd < 0) {
>>> +             pr_warn("prog '%s': failed to create %s '%s' legacy perf
>>> event: %s\n", prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
>>> libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
>>> +             return ERR_PTR(pfd);
>>> +     }
>>> +     link = bpf_program__attach_perf_event_legacy(prog, pfd);
>>> +     if (IS_ERR(link)) {
>>> +             close(pfd);
>>> +             err = PTR_ERR(link);
>>> +             pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
>>> prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
>>> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>>> +             return link;
>>> +     }
>>> +     /* needed history for the legacy probe cleanup */
>>> +     link->legacy.name = func_name;
>>> +     link->legacy.retprobe = retprobe;
>>
>> Note I’m not setting those variables inside
>> bpf_program__atach_perf_event_legacy(). They’re not available
>> there and I did not want to make them to be (through arguments).
>
> as I said above, you shouldn't assume that func_name will still be
> allocated by the time you get to detaching kprobe. You should strdup()
> or do whatever is necessary to own necessary memory.

+1

>
>>> +
>>> +     return link;
>>> +}
>>> +
>>>  static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
>>>                                     struct bpf_program *prog)
>>>  {
>>> @@ -9797,6 +10143,9 @@ static struct bpf_link */(const struct
>>> bpf_sec_def *sec,
>>>       func_name = prog->sec_name + sec->len;
>>>       retprobe = strcmp(sec->sec, "kretprobe/") == 0;
>>>
>>> +     if(determine_kprobe_legacy())
>>> +             return bpf_program__attach_kprobe_legacy(prog, retprobe,  
>>> func_name);
>>> +
>
> the other way around, attach_kprobe should just delegate to
> bpf_program__attach_kprobe, but bpf_program__attach_kprobe should be
> smart enough

Understood.

>
>>>      return bpf_program__attach_kprobe(prog, retprobe, func_name);
>>>  }
>>
>> I’m assuming this is okay based on your saying of detecting a feature
>> instead of using the if(x) if(y) approach.
>>
>>> @@ -11280,4 +11629,7 @@ void bpf_object__destroy_skeleton(struct
>>> bpf_object_skeleton *s)
>>>       free(s->maps);
>>>       free(s->progs);(),
>>>       free(s);
>>> +
>>> +     remove_kprobe_event_legacy("ip_set_create", false);
>>> +     remove_kprobe_event_legacy("ip_set_create", true);
>>
>> This is the main issue I wanted to show you before continuing.
>> I cannot remove the kprobe event unless the obj is unloaded.
>> That is why I have this hard coded here, just because I was
>> testing. Any thoughts how to cleanup the kprobes without
>> jeopardising the API too much ?
>
> cannot as in it doesn't work for whatever reason? Or what do you mean?
>
> I see that you had bpf_link__detach_perf_event_legacy calling
> remove_kprobe_event_legacy, what didn't work?
>

I’m sorry for not being very clear here. What happens is that, if I
try to remove the kprobe_event_legacy() BEFORE:

if (s->progs)
	bpf_object__detach_skeleton(s);
if (s->obj)
	bpf_object__close(*s->obj);

It fails with generic write error on kprobe_events file. I need to
remove legacy kprobe AFTER object closure. To workaround this on
my project, and to show you this issue, I have come up with:

void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
{
         int i, j;
         struct probeleft {
                 char *probename;
                 bool retprobe;
         } probesleft[24];

         for (i = 0, j = 0; i < s->prog_cnt; i++) {
                 struct bpf_link **link = s->progs[i].link;
                 if ((*link)->legacy.name) {
                         memset(&probesleft[j], 0, sizeof(struct probeleft));
                         probesleft[j].probename = strdup((*link)->legacy.name);
                         probesleft[j].retprobe = (*link)->legacy.retprobe;
                         j++;
                 }
         }

         if (s->progs)
                 bpf_object__detach_skeleton(s);
         if (s->obj)
                 bpf_object__close(*s->obj);
         free(s->maps);
         free(s->progs);
         free(s);

         for (j--; j >= 0; j--) {
                 remove_kprobe_event_legacy(probesleft[j].probename, probesleft[j].retprobe);
                 free(probesleft[j].probename);
         }
}

Which, of course, is not what I’m suggesting to the lib, but shows
the problem and gives you a better idea on how to solve it not
breaking the API.

> You somehow ended up with 3 times more code and I have more questions
> now then before. When you say "it doesn't work", please make sure to
> explain what exactly doesn't work, what you did, what you expected to
> happen/see.

Deal. Thanks a lot for reviewing all this.

-rafaeldtinoco

