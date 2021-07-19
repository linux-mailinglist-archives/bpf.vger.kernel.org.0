Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B083CCC15
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 03:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhGSCCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Jul 2021 22:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGSCCn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Jul 2021 22:02:43 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF954C061762
        for <bpf@vger.kernel.org>; Sun, 18 Jul 2021 18:59:44 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z11so18268126iow.0
        for <bpf@vger.kernel.org>; Sun, 18 Jul 2021 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:mime-version:message-id:in-reply-to:references:date:from
         :to:cc:subject;
        bh=UkR21tc2CHA1F4Jj8DxgoSjYgObceynpI78rP5XsvUQ=;
        b=lsfkW1o3uRjfWTSxMu73bnSv5vQKCnAKJjUxDz+EPfoHUvqxuvsYB0BbSwNfOFO6hc
         J9VU85TWnWCk6oHKNErp8xCNSvU86VU1YuyeNF/Lbuntsi2GlQVbZj1sELjPOCUNAuB0
         4h6O+LstYe6BsnhSR17A5T29cUQMIeMakvtclplZp1SpcGl4YMCqti4IIa+MLHDEIP36
         /XuA7DCaozGNQxBu7cuvNMdB/q/aibvEicqu2OEo5bdKPm4PO11G8dsJ9Wx7UmPCPkY4
         1+8l0d+VgFHVT9S9iOmTMrGoNzE5FYOP1kWOorrLpHemMtJvONniDYa8SuJ9mO/AwD22
         HQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:mime-version:message-id:in-reply-to
         :references:date:from:to:cc:subject;
        bh=UkR21tc2CHA1F4Jj8DxgoSjYgObceynpI78rP5XsvUQ=;
        b=qimY3C0VI2YXFWOv26YQ+JxO4L5+qYj8X/fSboLrlbajpvKpqS82pttWaa4fdMVzLC
         0X4hjammah2tnyh6aIjLcBTVcIH6oQWhQW6w7qvNjXgo5ny+aQ70GfULnki3P07K2zqO
         COcA8QSNLCiF5fOHVzQzlKIDHWsKXQJ2ZHbJ7In7snqvY05ANOFmvaeY1DqZd7YoBV5H
         y5RnfoZs8UAHMbdzsECASh/T9sNiGEN3g5+s7du0Kx7JmhZojQ6rF83IoLCM5Zs+hq+0
         iQfb34KJdnd5uGI3cuIT2HVyYQ4H5SH3a/mTte/zf1CxSXjQBXMea/x+wWZxV06B8dCF
         32LA==
X-Gm-Message-State: AOAM5326AH2Lbi5cqB8gea5Kv9OvS7V9AgmQvSIC3i7aRueISgq9tiAg
        1UsaG1HzJuhgsXIbvfmgEg==
X-Google-Smtp-Source: ABdhPJzzz7/XNfVY4cfZM6rhGpg20OPD+DzPTeEbjjy1kgsKNhUvM3CR42Fke4K1ukbOgq3BQG5+4g==
X-Received: by 2002:a05:6638:16c4:: with SMTP id g4mr19552855jat.86.1626659983858;
        Sun, 18 Jul 2021 18:59:43 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v11sm8806460ilh.52.2021.07.18.18.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 18:59:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6E13D27C0074;
        Sun, 18 Jul 2021 21:59:42 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute3.internal (MEProxy); Sun, 18 Jul 2021 21:59:42 -0400
X-ME-Sender: <xms:jdz0YGHF7DZulVomaDbbynws5SATl0-5AyPh-qLnavCuV4WDaW6jWA>
    <xme:jdz0YHVMh3coF7tJISE2duasF6Qm_me2M4aYenJxHbKkYySc8vNDLnj_L_z3QDHRh
    TzbI_1KdNEc-WkBoG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftfgrfhgr
    vghlucffrghvihguucfvihhnohgtohdfuceorhgrfhgrvghlughtihhnohgtohesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepledtteelfeekjeelvdelieejfefhkeeu
    ffeitedutdelueefkefhvedtffeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrfhgrvghlughtihhnohgtohdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduvdehieehledtgedqvdehheekjeelfeeiqdhrrg
    hfrggvlhguthhinhhotghopeepghhmrghilhdrtghomhesuddvfehmrghilhdrohhrgh
X-ME-Proxy: <xmx:jtz0YAIEiVy0TgylM5Nga41mKFAqE8vCj8R5jrvdd2LXBVsu3nQ4ig>
    <xmx:jtz0YAHtqzIbCBcQ5y7FFnm9Kkk1SsahJmBLD90wdtRAWfx1fW08Ug>
    <xmx:jtz0YMWTUqHsQgCXQZVyXGIjWl4iBBABxkWUvC4wWaMP0JunWLyw1g>
    <xmx:jtz0YPC4mph7ZhwHkgwhIz14TliHM58qYAapatqTT_SSZdKVCk6hWA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D7BB24E08FF; Sun, 18 Jul 2021 21:59:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-533-gf73e617b8a-fm-20210712.002-gf73e617b
Mime-Version: 1.0
Message-Id: <701c5dea-2db9-4df8-888b-9e10c854afc3@www.fastmail.com>
In-Reply-To: <CAEf4BzYz4BJp8beyoKD03ao4PuvuDg+QpMszeJSGrqPC==JoGw@mail.gmail.com>
References: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
 <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
 <CAEf4BzYz4BJp8beyoKD03ao4PuvuDg+QpMszeJSGrqPC==JoGw@mail.gmail.com>
Date:   Sun, 18 Jul 2021 22:59:21 -0300
From:   "Rafael David Tinoco" <rafaeldtinoco@gmail.com>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_bpf-next_v3]_libbpf:_introduce_legacy_kprobe_events?=
 =?UTF-8?Q?_support?=
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10007,6 +10007,10 @@ struct bpf_link {
> >         char *pin_path;         /* NULL, if not pinned */
> >         int fd;                 /* hook FD, -1 if not applicable */
> >         bool disconnected;
> > +       struct {
> > +               char *name;
> > +               bool retprobe;
> > +       } legacy;
>
> we shouldn't extend common bpf_link with kprobe-specific parts. We
> used to have something like this (for other use cases):
>
> struct bpf_link_kprobe {
>     struct bpf_link link;
>     char *legacy_name;
>     bool is_retprobe;
> };

would this:

struct bpf_link {
    int (*detach)(struct bpf_link *link);
    int (*destroy)(struct bpf_link *link);
    char *pin_path;
    int fd;
    bool disconnected;
};

struct bpf_link_kprobe {
    char *legacy_name;
    bool is_retprobe;
    struct bpf_link *link;
};

be ok ?

> And then internally do container_of() to "cast" struct bpf_link to
> struct bpf_link_kprobe. External API should still operate on struct
> bpf_link everywhere.

and what about this:

static struct bpf_link*
bpf_program__attach_kprobe_opts(struct bpf_program *prog,
                                const char *func_name,
                                struct bpf_program_attach_kprobe_opts *opts)
{
	char errmsg[STRERR_BUFSIZE];
	struct bpf_link_kprobe *kplink;
	int pfd, err;
	bool legacy;

	legacy = determine_kprobe_legacy();
	if (!legacy) {
		pfd = perf_event_open_probe(false /* uprobe */,
		                            opts->retprobe,
		                            func_name,
		                            0 /* offset */,
		                            -1 /* pid */);
	} else {
		pfd = perf_event_open_kprobe_legacy(opts->retprobe,
		                                    func_name,
		                                    0 /* offset */,
		                                    -1 /* pid */);
	}
	if (pfd < 0) {
		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
		        prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
		        libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
		return libbpf_err_ptr(pfd);
	}
	kplink = calloc(1, sizeof(struct bpf_link_kprobe));
	if (!kplink)
		return libbpf_err_ptr(-ENOMEM);
	kplink->link = bpf_program__attach_perf_event(prog, pfd);
	err = libbpf_get_error(link);
	if (err) {
		free(kplink);
		close(pfd);
		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
		        prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
		        libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
		return libbpf_err_ptr(err);
	}
	if (legacy) {
		kplink->legacy_name = strdup(func_name);
		kplink->is_retprobe = opts->retprobe;
	}

	return kplink->link;
}

And use this 'kplink->link' pointer as the bpf_link pointer for all kprobe
functions. For the detachment we would have something like:

static int bpf_link__detach_perf_event(struct bpf_link *link) {
	struct bpf_link *const *plink;
	struct bpf_link_kprobe *kplink;
	int err;

	plink = (struct bpf_link *const *) link;
	kplink = container_of(plink, struct bpf_link_kprobe, link);
	err = ioctl(link->fd, PERF_EVENT_IOC_DISABLE, 0);
	if (err)
		err = -errno;
	close(link->fd);
	if (kplink) {
		remove_kprobe_event_legacy(kplink->legacy_name, kplink->is_retprobe);
		free(kplink->legacy_name);
		free(kplink);
	}

	return libbpf_err(err);
}

for the bpf_link__detach_perf_event(): This would also clean the container at
the detachment. (Next comment talks about having this here versus having a
legacy kprobe detachment callback).

[snip]

> >  static int bpf_link__detach_perf_event(struct bpf_link *link)
> >  {
> >         int err;
> > @@ -10152,6 +10197,12 @@ static int bpf_link__detach_perf_event(struct bpf_link *link)
> >                 err = -errno;
> >
> >         close(link->fd);
> > +
> > +       if (link->legacy.name) {
> > +               remove_kprobe_event_legacy(link->legacy.name, link->legacy.retprobe);
> > +               free(link->legacy.name);
> > +       }
>
> instead of this check in bpf_link__detach_perf_event, attach_kprobe
> should install its own bpf_link__detach_kprobe_legacy callback

attach_kprobe_opts() could pass a pointer to link->detach->callback through the
opts I suppose (or now, the kplink->link->detach->callback). This way the
default would still be bpf_link__detach_perf_event() but we could create a
function bpf_link__detach_perf_event_legacy_kprobe() with what was previously
showed (about kplink freeing). This is not needed with the version showed
before the [snip] though.

> > +static int perf_event_open_probe_legacy(bool uprobe, bool retprobe, const char *name,
> > +                                       uint64_t offset, int pid)
>
> you are not using offset here, let's pass it into
> add_kprobe_event_legacy and use it when attaching as "p:kprobes/%s
> %s+123" in poke_kprobe_events? There are separate patches that are
> adding ability to attach kprobe at offset, so let's support that
> (internally) from the get go for legacy case as well.
>
> also, it's not generic perf_event_open, it's specifically kprobe, so
> let's call it with kprobe in the name (e.g., kprobe_open_legacy or
> something)

I'm calling it now perf_event_open_kprobe_legacy() and it calls:

static inline int add_kprobe_event_legacy(const char *name, bool retprobe, uint64_t offset)
{
	return poke_kprobe_events(true, name, retprobe, offset);
}

and then we set {kprobes/kretprobes}/funcname_pid, also supporting offset:

static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_t offset) {
	int fd, ret = 0;
	char cmd[192] = {}, probename[128] = {}, probefunc[128] = {};
	const char *file = "/sys/kernel/debug/tracing/kprobe_events";

	if (retprobe)
		ret = snprintf(probename, sizeof(probename), "kretprobes/%s_libbpf_%u", name, getpid());
	else
		ret = snprintf(probename, sizeof(probename), "kprobes/%s_libbpf_%u", name, getpid());
	if (offset)
		ret = snprintf(probefunc, sizeof(probefunc), "%s+%lu", name, offset);
	if (ret)
		return -EINVAL;
	if (add) {
		snprintf(cmd, sizeof(cmd), "%c:%s %s",
				 retprobe ? 'r' : 'p',
				 probename,
		         offset ? probefunc : name);
	} else {
		snprintf(cmd, sizeof(cmd), "-:%s", probename);
	}
	fd = open(file, O_WRONLY | O_APPEND, 0);
	if (!fd)
		return -errno;
	ret = write(fd, cmd, strlen(cmd));
	if (ret)
		ret = -errno;
	close(fd);

	return ret;
}

[snip]

> > +               pfd = perf_event_open_probe(false /* uprobe */,
> > +                                           retprobe, func_name,
> > +                                            0 /* offset */,
> > +                                           -1 /* pid */);
> > +       else
> > +               pfd = perf_event_open_probe_legacy(false /* uprobe */,
> > +                                           retprobe, func_name,
> > +                                            0 /* offset */,
> > +                                           -1 /* pid */);
> >         if (pfd < 0) {
> >                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
> >                         prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
>
> we can't use bpf_program__attach_perf_event as is now, because we need
> to allocate a different struct bpf_link_kprobe.

We could do the container encapsulation using heap in
bpf_program_attach_kprobe_opts() or attach_kprobe() like I'm showing here, no ?

...
	kplink = calloc(1, sizeof(struct bpf_link_kprobe));
	if (!kplink)
		return libbpf_err_ptr(-ENOMEM);
	kplink->link = bpf_program__attach_perf_event(prog, pfd);
...

and then free all this structure (bpf_link and its encapsulation at the
detachment, like said previously also). This way we don't have to change
bpf_program__attach_perf_event() which would continue to serve
bpf_program__attach_tracepoint() and bpf_program__attach_uprobe() unmodified.
This way, kprobe would have a container for all cases and uprobe and tracepoint
could have a container in the future if needed.

> Let's extract the
> PERF_EVENT_IOC_SET_BPF and PERF_EVENT_IOC_ENABLE logic into a helper
> and use it from both bpf_program__attach_perf_event and
> bpf_program__attach_kprobe. It's actually good because we can check
> silly errors (like prog_fd < 0) before we create perf_event FD now.

Okay, but I'm considering this orthogonal to what you said previously (on
changing bpf_program__attach_perf_event). UNLESS you really prefer me to do the
container allocation in bpf_program__attach_perf_event() but then we would have
to free the container in all detachments (kprobe, tracepoint and uprobe) as it
couldn't be placed in stack (or it would eventually be lost, no ?).
