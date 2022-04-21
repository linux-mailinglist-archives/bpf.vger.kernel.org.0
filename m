Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C650A1B9
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388977AbiDUOLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388950AbiDUOLH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 961493A739
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDnlYa2OMkqEeLhYEcPDezCSxy/pkOwx9St1vGliNJo=;
        b=ZXSBSOLVFzO1kMPGtG4eKE6gPbByx2tItduFLqeCetvTbjgeNTy7lCksTdulLIbSIc3KuR
        YyqRO0efdQeRvTw2o34N/rg/65BSKGnE5dAgD4mcnXWWOMadzwvLUZ9k2+bd4tqh9V+b1T
        mWTPalxZQ2G0LP1U7jeSoBsYSFyY+k0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-0cIPWYktOpm8NPl29RvK8w-1; Thu, 21 Apr 2022 10:08:09 -0400
X-MC-Unique: 0cIPWYktOpm8NPl29RvK8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7878C18A6584;
        Thu, 21 Apr 2022 14:08:02 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35DC140EC002;
        Thu, 21 Apr 2022 14:08:00 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC bpf-next v4 7/7] selftests/bpf: add tests for the HID-bpf initial implementation
Date:   Thu, 21 Apr 2022 16:07:40 +0200
Message-Id: <20220421140740.459558-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test is pretty basic:
- create a virtual uhid device that no userspace will like (to not mess
  up the running system)
- attach a BPF prog to it
- open the matching hidraw node
- inject one event and check:
  * that the BPF program can do something on the event stream
  * can modify the event stream

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v4:
- manually retrieve the hidraw node from the sysfs (we can't get it for
  free from BPF)
- use the new API

changes in v3:
- squashed "hid: rely on uhid event to know if a test device is ready"
  into this one
- add selftests bpf VM config changes
- s/hidraw_ino/hidraw_number/

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 tools/testing/selftests/bpf/config           |   3 +
 tools/testing/selftests/bpf/prog_tests/hid.c | 482 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/hid.c      |  32 ++
 3 files changed, 517 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/hid.c
 create mode 100644 tools/testing/selftests/bpf/progs/hid.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 763db63a3890..b983c76535f8 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,3 +53,6 @@ CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_NF_CONNTRACK=y
 CONFIG_USERFAULTFD=y
+CONFIG_HID=y
+CONFIG_HIDRAW=y
+CONFIG_UHID=y
diff --git a/tools/testing/selftests/bpf/prog_tests/hid.c b/tools/testing/selftests/bpf/prog_tests/hid.c
new file mode 100644
index 000000000000..624853fb0f7d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/hid.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red Hat */
+#include <test_progs.h>
+#include <testing_helpers.h>
+#include "hid.skel.h"
+
+#include <fcntl.h>
+#include <fnmatch.h>
+#include <dirent.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <linux/uhid.h>
+
+static unsigned char rdesc[] = {
+	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
+	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
+	0xa1, 0x01,		/* COLLECTION (Application) */
+	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
+	0xa1, 0x00,			/* COLLECTION (Physical) */
+	0x85, 0x01,				/* REPORT_ID (1) */
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0x81, 0x02,				/* INPUT (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x81, 0x01,				/* INPUT (Cnst,Var,Abs) */
+	0x05, 0x01,				/* USAGE_PAGE (Generic Desktop) */
+	0x09, 0x30,				/* USAGE (X) */
+	0x09, 0x31,				/* USAGE (Y) */
+	0x15, 0x81,				/* LOGICAL_MINIMUM (-127) */
+	0x25, 0x7f,				/* LOGICAL_MAXIMUM (127) */
+	0x75, 0x10,				/* REPORT_SIZE (16) */
+	0x95, 0x02,				/* REPORT_COUNT (2) */
+	0x81, 0x06,				/* INPUT (Data,Var,Rel) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0x91, 0x02,				/* Output (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x06,				/* USAGE_MINIMUM (6) */
+	0x29, 0x08,				/* USAGE_MAXIMUM (8) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0xb1, 0x02,				/* Feature (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0xc0,				/* END_COLLECTION */
+	0xc0,			/* END_COLLECTION */
+};
+
+static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
+
+/* no need to protect uhid_stopped, only one thread accesses it */
+static bool uhid_stopped;
+
+static int uhid_write(int fd, const struct uhid_event *ev)
+{
+	ssize_t ret;
+
+	ret = write(fd, ev, sizeof(*ev));
+	if (ret < 0) {
+		fprintf(stderr, "Cannot write to uhid: %m\n");
+		return -errno;
+	} else if (ret != sizeof(*ev)) {
+		fprintf(stderr, "Wrong size written to uhid: %zd != %zu\n",
+			ret, sizeof(ev));
+		return -EFAULT;
+	} else {
+		return 0;
+	}
+}
+
+static int create(int fd, int rand_nb)
+{
+	struct uhid_event ev;
+	char buf[25];
+
+	sprintf(buf, "test-uhid-device-%d", rand_nb);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char *)ev.u.create.name, buf);
+	ev.u.create.rd_data = rdesc;
+	ev.u.create.rd_size = sizeof(rdesc);
+	ev.u.create.bus = BUS_USB;
+	ev.u.create.vendor = 0x0001;
+	ev.u.create.product = 0x0a37;
+	ev.u.create.version = 0;
+	ev.u.create.country = 0;
+
+	sprintf(buf, "%d", rand_nb);
+	strcpy((char *)ev.u.create.phys, buf);
+
+	return uhid_write(fd, &ev);
+}
+
+static void destroy(int fd)
+{
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	uhid_write(fd, &ev);
+}
+
+static int event(int fd)
+{
+	struct uhid_event ev;
+	ssize_t ret;
+
+	memset(&ev, 0, sizeof(ev));
+	ret = read(fd, &ev, sizeof(ev));
+	if (ret == 0) {
+		fprintf(stderr, "Read HUP on uhid-cdev\n");
+		return -EFAULT;
+	} else if (ret < 0) {
+		fprintf(stderr, "Cannot read uhid-cdev: %m\n");
+		return -errno;
+	} else if (ret != sizeof(ev)) {
+		fprintf(stderr, "Invalid size read from uhid-dev: %zd != %zu\n",
+			ret, sizeof(ev));
+		return -EFAULT;
+	}
+
+	switch (ev.type) {
+	case UHID_START:
+		pthread_mutex_lock(&uhid_started_mtx);
+		pthread_cond_signal(&uhid_started);
+		pthread_mutex_unlock(&uhid_started_mtx);
+
+		fprintf(stderr, "UHID_START from uhid-dev\n");
+		break;
+	case UHID_STOP:
+		uhid_stopped = true;
+
+		fprintf(stderr, "UHID_STOP from uhid-dev\n");
+		break;
+	case UHID_OPEN:
+		fprintf(stderr, "UHID_OPEN from uhid-dev\n");
+		break;
+	case UHID_CLOSE:
+		fprintf(stderr, "UHID_CLOSE from uhid-dev\n");
+		break;
+	case UHID_OUTPUT:
+		fprintf(stderr, "UHID_OUTPUT from uhid-dev\n");
+		break;
+	case UHID_GET_REPORT:
+		fprintf(stderr, "UHID_GET_REPORT from uhid-dev\n");
+		break;
+	case UHID_SET_REPORT:
+		fprintf(stderr, "UHID_SET_REPORT from uhid-dev\n");
+		break;
+	default:
+		fprintf(stderr, "Invalid event from uhid-dev: %u\n", ev.type);
+	}
+
+	return 0;
+}
+
+static void *read_uhid_events_thread(void *arg)
+{
+	int fd = *(int *)arg;
+	struct pollfd pfds[1];
+	int ret = 0;
+
+	pfds[0].fd = fd;
+	pfds[0].events = POLLIN;
+
+	uhid_stopped = false;
+
+	while (!uhid_stopped) {
+		ret = poll(pfds, 1, 100);
+		if (ret < 0) {
+			fprintf(stderr, "Cannot poll for fds: %m\n");
+			break;
+		}
+		if (pfds[0].revents & POLLIN) {
+			ret = event(fd);
+			if (ret)
+				break;
+		}
+	}
+
+	return (void *)(long)ret;
+}
+
+static int uhid_start_listener(pthread_t *tid, int uhid_fd)
+{
+	int fd = uhid_fd;
+
+	pthread_mutex_lock(&uhid_started_mtx);
+	if (CHECK_FAIL(pthread_create(tid, NULL, read_uhid_events_thread,
+				      (void *)&fd))) {
+		pthread_mutex_unlock(&uhid_started_mtx);
+		close(fd);
+		return -EIO;
+	}
+	pthread_cond_wait(&uhid_started, &uhid_started_mtx);
+	pthread_mutex_unlock(&uhid_started_mtx);
+
+	return 0;
+}
+
+static int send_event(int fd, u8 *buf, size_t size)
+{
+	struct uhid_event ev;
+
+	if (size > sizeof(ev.u.input.data))
+		return -E2BIG;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT2;
+	ev.u.input2.size = size;
+
+	memcpy(ev.u.input2.data, buf, size);
+
+	return uhid_write(fd, &ev);
+}
+
+static int setup_uhid(int rand_nb)
+{
+	int fd;
+	const char *path = "/dev/uhid";
+	int ret;
+
+	fd = open(path, O_RDWR | O_CLOEXEC);
+	if (!ASSERT_GE(fd, 0, "open uhid-cdev"))
+		return -EPERM;
+
+	ret = create(fd, rand_nb);
+	if (!ASSERT_OK(ret, "create uhid device")) {
+		close(fd);
+		return -EPERM;
+	}
+
+	return fd;
+}
+
+static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *dir)
+{
+	const char *target = "0003:0001:0A37.*";
+	char phys[512];
+	char uevent[1024];
+	char temp[512];
+	int fd, nread;
+	bool found = false;
+
+	if (fnmatch(target, dir->d_name, 0))
+		return false;
+
+	/* we found the correct VID/PID, now check for phys */
+	sprintf(uevent, "%s/%s/uevent", workdir, dir->d_name);
+
+	fd = open(uevent, O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return false;
+
+	sprintf(phys, "PHYS=%d", dev_id);
+
+	nread = read(fd, temp, ARRAY_SIZE(temp));
+	if (nread > 0 && (strstr(temp, phys)) != NULL)
+		found = true;
+
+	close(fd);
+
+	return found;
+}
+
+static int get_sysfs_fd(int dev_id)
+{
+	const char *workdir = "/sys/devices/virtual/misc/uhid";
+	char uevent[1024];
+	DIR *d;
+	struct dirent *dir;
+	int found = -1;
+
+	/* it would be nice to be able to use nftw, but the no_alu32 target doesn't support it */
+
+	d = opendir(workdir);
+	if (d) {
+		while ((dir = readdir(d)) != NULL) {
+			if (!match_sysfs_device(dev_id, workdir, dir))
+				continue;
+
+			sprintf(uevent, "%s/%s/uevent", workdir, dir->d_name);
+
+			found = open(uevent, O_RDONLY | O_NONBLOCK);
+			if (found > 0)
+				break;
+		}
+		closedir(d);
+	}
+
+	return found;
+}
+
+static int get_hidraw(int dev_id)
+{
+	const char *workdir = "/sys/devices/virtual/misc/uhid";
+	char sysfs[1024];
+	DIR *d, *subd;
+	struct dirent *dir, *subdir;
+	int i, found = -1;
+
+	/* retry 5 times in case the system is loaded */
+	for (i = 5; i > 0; i--) {
+		usleep(10);
+		d = opendir(workdir);
+
+		if (!d)
+			continue;
+
+		while ((dir = readdir(d)) != NULL) {
+			if (!match_sysfs_device(dev_id, workdir, dir))
+				continue;
+
+			sprintf(sysfs, "%s/%s/hidraw", workdir, dir->d_name);
+
+			subd = opendir(sysfs);
+			if (!subd)
+				continue;
+
+			while ((subdir = readdir(subd)) != NULL) {
+				if (fnmatch("hidraw*", subdir->d_name, 0))
+					continue;
+
+				found = atoi(subdir->d_name + strlen("hidraw"));
+			}
+
+			closedir(subd);
+
+			if (found > 0)
+				break;
+		}
+		closedir(d);
+	}
+
+	return found;
+}
+
+/*
+ * Attach hid_first_event to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the program sees it and can change the data
+ */
+static int test_hid_raw_event(struct hid *hid_skel, int uhid_fd, int sysfs_fd, int dev_id)
+{
+	int err, hidraw_number, hidraw_fd = -1;
+	char hidraw_path[64] = {0};
+	u8 buf[10] = {0};
+	int ret = -1;
+
+	/* check that the program is correctly loaded */
+	ASSERT_EQ(hid_skel->data->callback_check, 52, "callback_check1");
+	ASSERT_EQ(hid_skel->data->callback2_check, 52, "callback2_check1");
+
+	/* attach the first program */
+	hid_skel->links.hid_first_event =
+		bpf_program__attach(hid_skel->progs.hid_first_event);
+	if (!ASSERT_OK_PTR(hid_skel->links.hid_first_event,
+			   "attach_hid(hid_first_event)"))
+		return PTR_ERR(hid_skel->links.hid_first_event);
+
+	hidraw_number = get_hidraw(dev_id);
+	if (!ASSERT_GE(hidraw_number, 0, "get_hidraw"))
+		goto cleanup;
+
+	/* open hidraw node to check the other side of the pipe */
+	sprintf(hidraw_path, "/dev/hidraw%d", hidraw_number);
+	hidraw_fd = open(hidraw_path, O_RDWR | O_NONBLOCK);
+
+	if (!ASSERT_GE(hidraw_fd, 0, "open_hidraw"))
+		goto cleanup;
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	send_event(uhid_fd, buf, 6);
+
+	/* check that hid_first_event() was executed */
+	ASSERT_EQ(hid_skel->data->callback_check, 42, "callback_check1");
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(hidraw_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, 6, "read_hidraw"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[2], 47, "hid_first_event"))
+		goto cleanup;
+
+	/* inject another event */
+	buf[0] = 1;
+	buf[1] = 47;
+	send_event(uhid_fd, buf, 6);
+
+	/* check that hid_first_event() was executed */
+	ASSERT_EQ(hid_skel->data->callback_check, 47, "callback_check1");
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(hidraw_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, 6, "read_hidraw"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[2], 52, "hid_first_event"))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	if (hidraw_fd >= 0)
+		close(hidraw_fd);
+
+	hid__detach(hid_skel);
+
+	return ret;
+}
+
+void serial_test_hid_bpf(void)
+{
+	struct hid *hid_skel = NULL;
+	int err, uhid_fd, sysfs_fd;
+	void *uhid_err;
+	time_t t;
+	pthread_t tid;
+	int dev_id;
+
+	/* initialize random number generator */
+	srand((unsigned int)time(&t));
+
+	dev_id = rand() % 1024;
+
+	uhid_fd = setup_uhid(dev_id);
+	if (!ASSERT_GE(uhid_fd, 0, "setup uhid"))
+		return;
+
+	err = uhid_start_listener(&tid, uhid_fd);
+	ASSERT_OK(err, "uhid_start_listener");
+
+	/* locate the uevent file of the created device */
+	sysfs_fd = get_sysfs_fd(dev_id);
+	if (!ASSERT_GE(sysfs_fd, 0, "locate sysfs uhid device"))
+		goto cleanup;
+
+	hid_skel = hid__open_and_load();
+	if (!ASSERT_OK_PTR(hid_skel, "hid_skel_load"))
+		goto cleanup;
+
+	/* start the tests! */
+	err = test_hid_raw_event(hid_skel, uhid_fd, sysfs_fd, dev_id);
+	ASSERT_OK(err, "hid");
+
+cleanup:
+	hid__destroy(hid_skel);
+	destroy(uhid_fd);
+
+	pthread_join(tid, &uhid_err);
+	err = (int)(long)uhid_err;
+	CHECK_FAIL(err);
+}
diff --git a/tools/testing/selftests/bpf/progs/hid.c b/tools/testing/selftests/bpf/progs/hid.c
new file mode 100644
index 000000000000..37cc98ca206b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/hid.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red hat */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern __u8 *hid_bpf_kfunc_get_data(struct hid_bpf_ctx *ctx,
+				    unsigned int offset,
+				    const size_t __sz) __ksym;
+extern void hid_bpf_kfunc_data_release(__u8 *data) __ksym;
+
+__u64 callback_check = 52;
+__u64 callback2_check = 52;
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx, __s64 type)
+{
+	__u8 *rw_data = hid_bpf_kfunc_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
+
+	if (!rw_data)
+		return 0; /* EPERM check */
+
+	callback_check = rw_data[1];
+
+	rw_data[2] = rw_data[1] + 5;
+
+	hid_bpf_kfunc_data_release(rw_data);
+
+	return 0;
+}
-- 
2.35.1

