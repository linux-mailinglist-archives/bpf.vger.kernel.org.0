Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA482344E86
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 19:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhCVS0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 14:26:11 -0400
Received: from wforward2-smtp.messagingengine.com ([64.147.123.31]:40895 "EHLO
        wforward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232220AbhCVSZt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 14:25:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailforward.west.internal (Postfix) with ESMTP id AAE041812;
        Mon, 22 Mar 2021 14:25:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 14:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=jKe0UorUTb4dlJO0mm6tsr6B5bi1SkHbPtaWXSMdz
        JE=; b=AtYiD4U7wsCn7w0RDSzxnujt4Pg5eJujAsEnrBs4ebhfcEuJW/tPejI7F
        TUGeNy8iviW/mjIIgRTn/gH0QsSIEREszJPFGyT9DcCG/koEaM6Vwn6S4eG60zp3
        7AW17P9BW0A9VW/Gn89tLVJyxGOw9eVqCQch4P7ZRX3omeTq3nXD0hsT1B7zk3Y+
        XaZIrSuT0Ko4MswSBtavtwSBDKhK3HkYWb5IjWyDf9O+p//tcxc2LDz9yY8nfBI+
        DEStLg4h/oUn3FQJJ8t8AuqqIDsmccQ6KcRj80PEJidp868RuBMw4UqNKDMlVxgC
        18STFYy9psfc4HUeyuwvriEuH/HFw==
X-ME-Sender: <xms:K-FYYBaCbl3ZOzSZUT6T4la9P8f9ePjFjQHodLa3HbYJGvOJ7XyEIg>
    <xme:K-FYYCDayew0kQeCCfsta7Le_Dl9uCPULrpBawvbb79qJeGP-bWnwX8kJSI5LcYhR
    Tptla8B1GmrGHPhaOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuphgrmhfkphdqohhuthculdehtddtmdenucfjughrpegtggfuhfgjfffgkfhfvffo
    sehtkehmtdhhtdejnecuhfhrohhmpeftrghfrggvlhcuffgrvhhiugcuvfhinhhotghouc
    eorhgrfhgrvghlughtihhnohgtohesuhgsuhhnthhurdgtohhmqeenucggtffrrghtthgv
    rhhnpeeihfetudegteeuveevkeffjeffffehtdekkeefjeetfefgfeduleekteffgfelue
    enucfkphepudeluddrleeirddufedrvddufeenucfuphgrmhfkphepudeluddrleeirddu
    fedrvddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrrghfrggvlhguthhinhhotghosehusghunhhtuhdrtghomh
X-ME-Proxy: <xmx:K-FYYD-XPLN7fACCtMdw_n82EkZxfoMq0o-oKtL63ALdWZ49UL1o7A>
    <xmx:K-FYYC8IQQX4l1FA_HYNTQ8EqMBSNk2V0BqHetvMzTpqiPJayKTyLA>
    <xmx:K-FYYKc5KeCJSNIbivQxdij7o4To_njor7Xsn-qELtyhfk10JGhpAg>
    <xmx:K-FYYMJZMWfzP09hhgw8vNAxdCiQtQq8_yk9zyzaoF0xO0Lkz4ltlQW21ua3wM7I>
Received: from [10.6.2.232] (unknown [191.96.13.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACF68240426;
        Mon, 22 Mar 2021 14:25:45 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events
 support
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
Date:   Mon, 22 Mar 2021 15:25:40 -0300
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 638130340.71646-ebec39500176801a24002dbe9bb8b3d1
Content-Transfer-Encoding: 8bit
Message-Id: <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> - This is a RFC (v2).
> - Please check my reply with inline comments.

Comments bellow… (no correct formatting for now):

> ---
>  src/libbpf.c | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 357 insertions(+), 5 deletions(-)
>
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 3b1c79f..e9c6025 100644
> --- a/src/libbpf.c
> +++ b/src/libbpf.c
> @@ -9465,6 +9465,10 @@ struct bpf_link {
>  	char *pin_path;		/* NULL, if not pinned */
>  	int fd;			/* hook FD, -1 if not applicable */
>  	bool disconnected;
> +	struct {
> +		const char *name;
> +		bool retprobe;
> +	} legacy;
>  };

For bpf_link->detach() I needed func_name somewhere.

>
> +static inline int remove_kprobe_event_legacy(const char*, bool);
> +
>  static int bpf_link__detach_perf_event(struct bpf_link *link)
>  {
>  	int err;
> @@ -9605,8 +9612,25 @@ static int bpf_link__detach_perf_event(struct  
> bpf_link *link)
>  	err = ioctl(link->fd, PERF_EVENT_IOC_DISABLE, 0);
>  	if (err)
>  		err = -errno;
> -
>  	close(link->fd);
> +
> +	return err;
> +}
> +
> +static int bpf_link__detach_perf_event_legacy(struct bpf_link *link)
> +{
> +	int err;
> +
> +	err = bpf_link__detach_perf_event(link);
> +	if (err)
> +		err = -errno; // improve this
> +
> +	/*
> +	err = remove_kprobe_event_legacy(link->legacy.name,  
> link->legacy.retprobe);
> +	if (err)
> +		err = -errno;
> +	 */
> +
>  	return err;
>  }

Unfortunately I can’t remove kprobe event name from kprobe_events,
even if I unload it (0 >> enabled) before. It won’t work until the
object is fully unloaded. This is why previous version using
bpf_program__set_priv() used to work. I’m showing this bellow…

Check the last lines of this to understand better.

>
> @@ -9655,6 +9679,48 @@ struct bpf_link  
> *bpf_program__attach_perf_event(struct bpf_program *prog,
>  	return link;
>  }
>
> +struct bpf_link *bpf_program__attach_perf_event_legacy(struct  
> bpf_program *prog,
> +						       int pfd)
> +{
> +	char errmsg[STRERR_BUFSIZE];
> +	struct bpf_link *link;
> +	int prog_fd, err;
> +
> +	if (pfd < 0) {
> +		pr_warn("prog '%s': invalid perf event FD %d\n", prog->name, pfd);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	prog_fd = bpf_program__fd(prog);
> +	if (prog_fd < 0) {
> +		pr_warn("prog '%s': can't attach BPF program w/o FD (did  
> you load it?)\n", prog->name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	link = calloc(1, sizeof(*link));
> +	if (!link)
> +		return ERR_PTR(-ENOMEM);
> +
> +	link->detach = &bpf_link__detach_perf_event_legacy;

I created another function for all existing ones using _legacy at the end.
This one in particular could have a callback function as argument that would
be passed to link->detach().. this way I could avoid having 2 functions  
alike.

> +	link->fd = pfd;
> +
> +	if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
> +		err = -errno;
> +		free(link);
> +		pr_warn("prog '%s': failed to attach to pfd %d: %s\n",  
> prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		if (err == -EPROTO)
> +			pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN  
> to or remove exclude_callchain_[kernel|user] from pfd %d\n", prog->name,  
> pfd);
> +		return ERR_PTR(err);
> +	}
> +	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> +		err = -errno;
> +		free(link);
> +		pr_warn("prog '%s': failed to enable pfd %d: %s\n",  
> prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		return ERR_PTR(err);
> +	}
> +
> +	return link;
> +}
> +
>  /*
>   * this function is expected to parse integer in the range of [0, 2^31-1] from
>   * given file using scanf format string fmt. If actual parsed value is
> @@ -9685,34 +9751,242 @@ static int parse_uint_from_file(const char  
> *file, const char *fmt)
>  	return ret;
>  }
>
> +static int write_uint_to_file(const char *file, unsigned int val)
> +{
> +	char buf[STRERR_BUFSIZE];
> +	int err;
> +	FILE *f;
> +
> +	f = fopen(file, "w");
> +	if (!f) {
> +		err = -errno;
> +		pr_debug("failed to open '%s': %s\n", file,
> +			 libbpf_strerror_r(err, buf, sizeof(buf)));
> +		return err;
> +	}
> +	err = fprintf(f, "%u", val);
> +	if (err != 1) {
> +		err = -errno;
> +		pr_debug("failed to write '%u' to '%s': %s\n", val, file,
> +			libbpf_strerror_r(err, buf, sizeof(buf)));
> +		fclose(f);
> +		return err;
> +	}
> +	fclose(f);
> +	return 0;
> +}
> +
> +#define KPROBE_PERF_TYPE	"/sys/bus/event_source/devices/kprobe/type"
> +#define UPROBE_PERF_TYPE	"/sys/bus/event_source/devices/uprobe/type"
> +#define KPROBERET_FORMAT	 
> "/sys/bus/event_source/devices/kprobe/format/retprobe"
> +#define UPROBERET_FORMAT	 
> "/sys/bus/event_source/devices/uprobe/format/retprobe"
> +/* legacy kprobe events related files */
> +#define KPROBE_EVENTS		"/sys/kernel/debug/tracing/kprobe_events"
> +#define KPROBE_LEG_TOGGLE	"/sys/kernel/debug/kprobes/enabled"
> +#define KPROBE_LEG_ALL_TOGGLE	 
> "/sys/kernel/debug/tracing/events/kprobes/enable";
> +#define KPROBE_SINGLE_TOGGLE	 
> "/sys/kernel/debug/tracing/events/kprobes/%s/enable";
> +#define KPROBE_EVENT_ID	"/sys/kernel/debug/tracing/events/kprobes/%s/id";
> +

This made the life easier: to understand which files were related to what

> +static bool determine_kprobe_legacy(void)
> +{
> +	struct stat s;
> +
> +	return stat(KPROBE_PERF_TYPE, &s) == 0 ? false : true;
> +}
> +
>  static int determine_kprobe_perf_type(void)
>  {
> -	const char *file = "/sys/bus/event_source/devices/kprobe/type";
> +	const char *file = KPROBE_PERF_TYPE;
>
>  	return parse_uint_from_file(file, "%d\n");
>  }
>
>  static int determine_uprobe_perf_type(void)
>  {
> -	const char *file = "/sys/bus/event_source/devices/uprobe/type";
> +	const char *file = UPROBE_PERF_TYPE;
>
>  	return parse_uint_from_file(file, "%d\n");
>  }
>
>  static int determine_kprobe_retprobe_bit(void)
>  {
> -	const char *file =  
> "/sys/bus/event_source/devices/kprobe/format/retprobe";
> +	const char *file = KPROBERET_FORMAT;
>
>  	return parse_uint_from_file(file, "config:%d\n");
>  }
>
>  static int determine_uprobe_retprobe_bit(void)
>  {
> -	const char *file =  
> "/sys/bus/event_source/devices/uprobe/format/retprobe";
> +	const char *file = UPROBERET_FORMAT;
>
>  	return parse_uint_from_file(file, "config:%d\n");
>  }
>
> +static int toggle_kprobe_legacy(bool on)
> +{
> +	static int refcount;
> +	static bool initial, veryfirst;
> +	const char *file = KPROBE_LEG_TOGGLE;
> +
> +	if (on) {
> +		refcount++;
> +		if (veryfirst)
> +			return 0;
> +		veryfirst = true;
> +		/* initial value for KPROB_LEG_TOGGLE */
> +		initial = (bool) parse_uint_from_file(file, "%d\n");
> +		return write_uint_to_file(file, 1); /* enable kprobes */
> +	}
> +	refcount--;
> +	printf("DEBUG: kprobe_legacy refcount=%d\n", refcount);
> +	if (refcount == 0) {
> +		/* off ret value back to initial value if last consumer */
> +		return write_uint_to_file(file, initial);
> +	}
> +	return 0;
> +}
> +
> +static int toggle_kprobe_event_legacy_all(bool on)
> +{
> +	static int refcount;
> +	static bool initial, veryfirst;
> +	const char *file = KPROBE_LEG_ALL_TOGGLE;
> +
> +	if (on) {
> +		refcount++;
> +		if (veryfirst)
> +			return 0;
> +		veryfirst = true;
> +		// initial value for KPROB_LEG_ALL_TOGGLE
> +		initial = (bool) parse_uint_from_file(file, "%d\n");
> +		return write_uint_to_file(file, 1); // enable kprobes
> +	}
> +	refcount--;
> +	printf("DEBUG: legacy_all refcount=%d\n", refcount);
> +	if (refcount == 0) {
> +		// off ret value back to initial value if last consumer
> +		return write_uint_to_file(file, initial);
> +	}
> +	return 0;
> +}

Same thing here: 2 functions that could be reduced to one with an
argument to KPROB_LEG_TOGGLE or KPROB_LEG_ALL_TOGGLE.

I’m using static initial so I can recover the original status of
the “enable” files after the program is unloaded. Unfortunately
this is not multi-task friendly as another process would
step into this logic but I did not want to leave “enabled”
after we unload if it wasn’t before.

I’m saying this because of your idea of having PID as the kprobe
event names… it would have the same problem… We could, in theory
leave all “enabled” files enabled (1) at the end, use PID in the
kprobe event names and unload only our events… but then I would
leave /sys/kernel/debug/kprobes/enabled enabled even if it was
not.. because we could be concurrent to other tasks using libbpf.

> +static int kprobe_event_normalize(char *newname, size_t size, const char  
> *name, bool retprobe)
> +{
> +	int ret = 0;
> +
> +	if (IS_ERR(name))
> +		return -1;
> +
> +	if (retprobe)
> +		ret = snprintf(newname, size, "kprobes/%s_ret", name);
> +	else
> +		ret = snprintf(newname, size, "kprobes/%s", name);
> +
> +	if (ret <= strlen("kprobes/"))
> +		ret = -errno;
> +
> +	return ret;
> +}
> +
> +static int toggle_single_kprobe_event_legacy(bool on, const char *name,  
> bool retprobe)
> +{
> +	char probename[32], f[96];
> +	const char *file = KPROBE_SINGLE_TOGGLE;
> +	int ret;
> +
> +	ret = kprobe_event_normalize(probename, sizeof(probename), name,  
> retprobe);
> +	if (ret < 0)
> +		return ret;
> +
> +	snprintf(f, sizeof(f), file, probename + strlen("kprobes/"));
> +
> +	printf("DEBUG: writing %u to %s\n", (unsigned int) on, f);
> +
> +	ret = write_uint_to_file(f, (unsigned int) on);
> +
> +	return ret;
> +}
> +
> +static int poke_kprobe_events(bool add, const char *name, bool retprobe)
> +{
> +	int fd, ret = 0;
> +	char probename[32], cmd[96];
> +	const char *file = KPROBE_EVENTS;
> +
> +	ret = kprobe_event_normalize(probename, sizeof(probename), name,  
> retprobe);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (add)
> +		snprintf(cmd, sizeof(cmd),"%c:%s %s", retprobe ? 'r' : 'p',  
> probename, name);
> +	else
> +		snprintf(cmd, sizeof(cmd), "-:%s", probename);
> +
> +	printf("DEBUG: %s\n", cmd);
> +
> +	fd = open(file, O_WRONLY|O_APPEND, 0);
> +	if (!fd)
> +		return -errno;
> +	ret = write(fd, cmd, strlen(cmd));
> +	if (ret < 0)
> +		ret = -errno;
> +	close(fd);
> +
> +	return ret;
> +}
> +
> +static inline int add_kprobe_event_legacy(const char* func_name, bool  
> retprobe)
> +{
> +	int ret = 0;
> +
> +	ret = poke_kprobe_events(true, func_name, retprobe);
> +	if (ret < 0)
> +		printf("DEBUG: poke_kprobe_events (on) error\n");
> +
> +	ret = toggle_kprobe_event_legacy_all(true);
> +	if (ret < 0)
> +		printf("DEBUG: toggle_kprobe_event_legacy_all (on) error\n");
> +
> +	ret = toggle_single_kprobe_event_legacy(true, func_name, retprobe);
> +	if (ret < 0)
> +		printf("DEBUG: toggle_single_kprobe_event_legacy (on) error\n");
> +
> +	return ret;
> +}
> +
> +static inline int remove_kprobe_event_legacy(const char* func_name, bool  
> retprobe)
> +{
> +	int ret = 0;
> +
> +	ret = toggle_kprobe_event_legacy_all(true);
> +	if (ret < 0)
> +		printf("DEBUG: toggle_kprobe_event_legacy_all (off) error\n");
> +
> +	ret = toggle_single_kprobe_event_legacy(true, func_name, retprobe);
> +	if (ret < 0)
> +		printf("DEBUG: toggle_single_kprobe_event_legacy (off) error\n");
> +
> +	ret = toggle_single_kprobe_event_legacy(false, func_name, retprobe);
> +	if (ret < 0)
> +		printf("DEBUG: toggle_single_kprobe_event_legacy (off) error\n");
> +
> +	ret = poke_kprobe_events(false, func_name, retprobe);
> +	if (ret < 0)
> +		printf("DEBUG: poke_kprobe_events (off) error\n");
> +
> +	return ret;
> +}

I’m doing a “make sure what has to be enabled to be enabled” approach here.
Please ignore all the DEBUGs, etc, I’ll deal with errors after its good.

> +
> +static int determine_kprobe_perf_type_legacy(const char *func_name)
> +{
> +	char file[96];
> +	const char *fname = KPROBE_EVENT_ID;
> +
> +	snprintf(file, sizeof(file), fname, func_name);
> +
> +	return parse_uint_from_file(file, "%d\n");
> +}
> +
>  static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>  				 uint64_t offset, int pid)
>  {
> @@ -9760,6 +10034,51 @@ static int perf_event_open_probe(bool uprobe,  
> bool retprobe, const char *name,
>  	return pfd;
>  }
>
> +static int perf_event_open_probe_legacy(bool uprobe, bool retprobe,  
> const char *name,
> +					uint64_t offset, int pid)
> +{
> +	struct perf_event_attr attr = {};
> +	char errmsg[STRERR_BUFSIZE];
> +	int type, pfd, err;
> +
> +	if (uprobe) // legacy uprobe not supported yet
> +		return -1;

Would that be ok for now ? Until we are sure kprobe legacy interface is  
good ?

> +
> +	err = toggle_kprobe_legacy(true);
> +	if (err < 0) {
> +		pr_warn("failed to toggle kprobe legacy support: %s\n",  
> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		return err;
> +	}
> +	err = add_kprobe_event_legacy(name, retprobe);
> +	if (err < 0) {
> +		pr_warn("failed to add legacy kprobe event: %s\n",  
> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		return err;
> +	}
> +	type = determine_kprobe_perf_type_legacy(name);
> +	if (err < 0) {
> +		pr_warn("failed to determine legacy kprobe event id: %s\n",  
> libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
> +		return type;
> +	}
> +
> +	attr.size = sizeof(attr);
> +	attr.config = type;
> +	attr.type = PERF_TYPE_TRACEPOINT;
> +
> +	pfd = syscall(__NR_perf_event_open,
> +		      &attr,
> +		      pid < 0 ? -1 : pid,
> +		      pid == -1 ? 0 : -1,
> +		      -1,
> +		      PERF_FLAG_FD_CLOEXEC);
> +
> +	if (pfd < 0) {
> +		err = -errno;
> +		pr_warn("legacy kprobe perf_event_open() failed: %s\n",  
> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		return err;
> +	}
> +	return pfd;
> +}
> +
>  struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
>  					    bool retprobe,
>  					    const char *func_name)
> @@ -9788,6 +10107,33 @@ struct bpf_link  
> *bpf_program__attach_kprobe(struct bpf_program *prog,
>  	return link;
>  }
>
> +struct bpf_link *bpf_program__attach_kprobe_legacy(struct bpf_program  
> *prog,
> +						   bool retprobe,
> +						   const char *func_name)
> +{
> +	char errmsg[STRERR_BUFSIZE];
> +	struct bpf_link *link;
> +	int pfd, err;
> +
> +	pfd = perf_event_open_probe_legacy(false, retprobe, func_name, 0, -1);
> +	if (pfd < 0) {
> +		pr_warn("prog '%s': failed to create %s '%s' legacy perf  
> event: %s\n", prog->name, retprobe ? "kretprobe" : "kprobe", func_name,  
> libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> +		return ERR_PTR(pfd);
> +	}
> +	link = bpf_program__attach_perf_event_legacy(prog, pfd);
> +	if (IS_ERR(link)) {
> +		close(pfd);
> +		err = PTR_ERR(link);
> +		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",  
> prog->name, retprobe ? "kretprobe" : "kprobe", func_name,  
> libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		return link;
> +	}
> +	/* needed history for the legacy probe cleanup */
> +	link->legacy.name = func_name;
> +	link->legacy.retprobe = retprobe;

Note I’m not setting those variables inside
bpf_program__atach_perf_event_legacy(). They’re not available
there and I did not want to make them to be (through arguments).

> +
> +	return link;
> +}
> +
>  static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
>  				      struct bpf_program *prog)
>  {
> @@ -9797,6 +10143,9 @@ static struct bpf_link *attach_kprobe(const struct  
> bpf_sec_def *sec,
>  	func_name = prog->sec_name + sec->len;
>  	retprobe = strcmp(sec->sec, "kretprobe/") == 0;
>
> +	if(determine_kprobe_legacy())
> +		return bpf_program__attach_kprobe_legacy(prog, retprobe, func_name);
> +
>  	return bpf_program__attach_kprobe(prog, retprobe, func_name);
>  }

I’m assuming this is okay based on your saying of detecting a feature
instead of using the if(x) if(y) approach.

>
> @@ -11280,4 +11629,7 @@ void bpf_object__destroy_skeleton(struct  
> bpf_object_skeleton *s)
>  	free(s->maps);
>  	free(s->progs);
>  	free(s);
> +
> +	remove_kprobe_event_legacy("ip_set_create", false);
> +	remove_kprobe_event_legacy("ip_set_create", true);

This is the main issue I wanted to show you before continuing.
I cannot remove the kprobe event unless the obj is unloaded.
That is why I have this hard coded here, just because I was
testing. Any thoughts how to cleanup the kprobes without
jeopardising the API too much ?

>  }
> —
> 2.17.1


