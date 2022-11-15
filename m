Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3916262A0D4
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiKOR6H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiKOR6C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:58:02 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530112F3BC;
        Tue, 15 Nov 2022 09:57:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBYd21gn6z9xqwT;
        Wed, 16 Nov 2022 01:51:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHcW7o0nNj73dpAA--.16599S4;
        Tue, 15 Nov 2022 18:57:26 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 2/4] lsm: Add missing return values doc in lsm_hooks.h and fix formatting
Date:   Tue, 15 Nov 2022 18:56:50 +0100
Message-Id: <20221115175652.3836811-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHcW7o0nNj73dpAA--.16599S4
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr48CrW8Cr1rCF1kAry5Jwb_yoW8Ar18Ko
        WF9w47Xw1UKr17Ca1q9wn7Ga97u3ZY9F48CrsYq3s0yF9aqry5WayrA3W7Ja15Ar4UKa4D
        Xas7Aa4IvF4Ut3Wfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUO57kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
        vjxUxeHqDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj4F5bQABsy
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Ensure that for non-void LSM hooks there is a description of the return
values. Also replace spaces with tab for indentation, remove empty lines
between the hook description and the list of parameters and add the period
at the end of the parameter description.

Finally, replace the description of the sb_parse_opts_str hook, which was
removed with commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()"),
with one for the new hook sb_add_mnt_opt.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hooks.h | 123 ++++++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 37 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f40b82ca91e7..c0c570b7eabd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -92,6 +92,7 @@
  *	is initialised to NULL by the caller.
  *	@fc indicates the new filesystem context.
  *	@src_fc indicates the original filesystem context.
+ *	Return 0 on success or a negative error code on failure.
  * @fs_context_parse_param:
  *	Userspace provided a parameter to configure a superblock.  The LSM may
  *	reject it with an error and may use it for itself, in which case it
@@ -99,6 +100,9 @@
  *	the filesystem.
  *	@fc indicates the filesystem context.
  *	@param The parameter
+ *	Return 0 to indicate that the parameter should be passed on to the
+ *	filesystem, 1 to indicate that the parameter should be discarded or an
+ *	error to indicate that the parameter should be rejected.
  *
  * Security hooks for filesystem operations.
  *
@@ -118,6 +122,7 @@
  * 	Free memory associated with @mnt_ops.
  * @sb_eat_lsm_opts:
  * 	Eat (scan @orig options) and save them in @mnt_opts.
+ *	Return 0 if permission is granted.
  * @sb_statfs:
  *	Check permission before obtaining filesystem statistics for the @mnt
  *	mountpoint.
@@ -158,9 +163,11 @@
  *	@data contains the filesystem-specific data.
  *	Return 0 if permission is granted.
  * @sb_kern_mount:
- * 	Mount this @sb if allowed by permissions.
+ *	Mount this @sb if allowed by permissions.
+ *	Return 0 if permission is granted.
  * @sb_show_options:
  * 	Show (print on @m) mount options for this @sb.
+ *	Return 0 if permission is granted.
  * @sb_umount:
  *	Check permission before the @mnt file system is unmounted.
  *	@mnt contains the mounted file system.
@@ -176,18 +183,22 @@
  *	Set the security relevant mount options used for a superblock
  *	@sb the superblock to set security mount options for
  *	@opts binary data structure containing all lsm mount data
+ *	Return 0 on success, error on failure.
  * @sb_clone_mnt_opts:
  *	Copy all security options from a given superblock to another
  *	@oldsb old superblock which contain information to clone
  *	@newsb new superblock which needs filled in
- * @sb_parse_opts_str:
- *	Parse a string of security data filling in the opts structure
- *	@options string containing all mount options known by the LSM
- *	@opts binary data structure usable by the LSM
+ *	Return 0 on success, error on failure.
+ * @add_mnt_opt:
+ *	Add a new mount option @option with value @val and length @len to the
+ *	existing mount options @mnt_opts.
+ *	Return 0 if the option was successfully added, a negative value
+ *	otherwise.
  * @move_mount:
  *	Check permission before a mount is moved.
  *	@from_path indicates the mount that is going to be moved.
  *	@to_path indicates the mountpoint that will be mounted upon.
+ *	Return 0 if permission is granted.
  * @dentry_init_security:
  *	Compute a context for a dentry as the inode is not yet available
  *	since NFSv4 has no label backed by an EA anyway.
@@ -199,6 +210,7 @@
  *		    a pointer to static string.
  *	@ctx pointer to place the pointer to the resulting context in.
  *	@ctxlen point to place the length of the resulting context.
+ *	Return 0 if permission is granted.
  * @dentry_create_files_as:
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
@@ -209,6 +221,7 @@
  *	@name name of the last path component used to create file
  *	@old creds which should be used for context calculation
  *	@new creds to modify
+ *	Return 0 if permission is granted.
  *
  *
  * Security hooks for inode operations.
@@ -380,6 +393,7 @@
  * @path_notify:
  *	Check permissions before setting a watch on events as defined by @mask,
  *	on an object at @path, whose type is defined by @obj_type.
+ *	Return 0 if permission is granted.
  * @inode_readlink:
  *	Check the permission to read the symbolic link.
  *	@dentry contains the dentry structure for the file link.
@@ -439,9 +453,9 @@
  *	Retrieve a copy of the extended attribute representation of the
  *	security label associated with @name for @inode via @buffer.  Note that
  *	@name is the remainder of the attribute name after the security prefix
- *	has been removed. @alloc is used to specify of the call should return a
- *	value via the buffer or just the value length Return size of buffer on
- *	success.
+ *	has been removed. @alloc is used to specify if the call should return a
+ *	value via the buffer or just the value length.
+ *	Return size of buffer on success.
  * @inode_setsecurity:
  *	Set the security label associated with @name for @inode from the
  *	extended attribute value @value.  @size indicates the size of the
@@ -491,20 +505,22 @@
  *	to abort the copy up. Note that the caller is responsible for reading
  *	and writing the xattrs as this hook is merely a filter.
  * @d_instantiate:
- * 	Fill in @inode security information for a @dentry if allowed.
+ *	Fill in @inode security information for a @dentry if allowed.
  * @getprocattr:
- * 	Read attribute @name for process @p and store it into @value if allowed.
+ *	Read attribute @name for process @p and store it into @value if allowed.
+ *	Return the length of @value on success, a negative value otherwise.
  * @setprocattr:
- * 	Write (set) attribute @name to @value, size @size if allowed.
+ *	Write (set) attribute @name to @value, size @size if allowed.
+ *	Return written bytes on success, a negative value otherwise.
  *
  * Security hooks for kernfs node operations
  *
  * @kernfs_init_security:
  *	Initialize the security context of a newly created kernfs node based
  *	on its own and its parent's attributes.
- *
  *	@kn_dir the parent kernfs node
  *	@kn the new child kernfs node
+ *	Return 0 if permission is granted.
  *
  * Security hooks for file operations
  *
@@ -602,6 +618,7 @@
  *	Save open-time permission checking state for later use upon
  *	file_permission, and recheck access if anything has changed
  *	since inode_permission.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for task operations.
  *
@@ -619,6 +636,7 @@
  *	@gfp indicates the atomicity of any memory allocations.
  *	Only allocate sufficient memory and attach to @cred such that
  *	cred_transfer() will not get ENOMEM.
+ *	Return 0 on success, negative values on failure.
  * @cred_free:
  *	@cred points to the credentials.
  *	Deallocate and clear the cred->security field in a set of credentials.
@@ -627,6 +645,7 @@
  *	@old points to the original credentials.
  *	@gfp indicates the atomicity of any memory allocations.
  *	Prepare a new set of credentials by copying the data from the old set.
+ *	Return 0 on success, negative values on failure.
  * @cred_transfer:
  *	@new points to the new credentials.
  *	@old points to the original credentials.
@@ -873,6 +892,7 @@
  *	@type contains the requested communications type.
  *	@protocol contains the requested protocol.
  *	@kern set to 1 if a kernel socket.
+ *	Return 0 if permission is granted.
  * @socket_socketpair:
  *	Check permissions before creating a fresh pair of sockets.
  *	@socka contains the first socket structure.
@@ -956,6 +976,7 @@
  *	Must not sleep inside this hook because some callers hold spinlocks.
  *	@sk contains the sock (not socket) associated with the incoming sk_buff.
  *	@skb contains the incoming network data.
+ *	Return 0 if permission is granted.
  * @socket_getpeersec_stream:
  *	This hook allows the security module to provide peer socket security
  *	state for unix or connected tcp sockets to userspace via getsockopt
@@ -983,6 +1004,7 @@
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
  *	which is used to copy security attributes between local stream sockets.
+ *	Return 0 on success, error on failure.
  * @sk_free_security:
  *	Deallocate security structure.
  * @sk_clone_security:
@@ -995,17 +1017,19 @@
  * @inet_conn_request:
  *	Sets the openreq's sid to socket's sid with MLS portion taken
  *	from peer sid.
+ *	Return 0 if permission is granted.
  * @inet_csk_clone:
  *	Sets the new child socket's sid to the openreq sid.
  * @inet_conn_established:
  *	Sets the connection's peersid to the secmark on skb.
  * @secmark_relabel_packet:
- *	check if the process should be allowed to relabel packets to
- *	the given secid
+ *	Check if the process should be allowed to relabel packets to
+ *	the given secid.
+ *	Return 0 if permission is granted.
  * @secmark_refcount_inc:
- *	tells the LSM to increment the number of secmark labeling rules loaded
+ *	Tells the LSM to increment the number of secmark labeling rules loaded.
  * @secmark_refcount_dec:
- *	tells the LSM to decrement the number of secmark labeling rules loaded
+ *	Tells the LSM to decrement the number of secmark labeling rules loaded.
  * @req_classify_flow:
  *	Sets the flow's sid to the openreq sid.
  * @tun_dev_alloc_security:
@@ -1019,18 +1043,22 @@
  *	@security pointer to the TUN device's security structure
  * @tun_dev_create:
  *	Check permissions prior to creating a new TUN device.
+ *	Return 0 if permission is granted.
  * @tun_dev_attach_queue:
  *	Check permissions prior to attaching to a TUN device queue.
  *	@security pointer to the TUN device's security structure.
+ *	Return 0 if permission is granted.
  * @tun_dev_attach:
  *	This hook can be used by the module to update any security state
  *	associated with the TUN device's sock structure.
  *	@sk contains the existing sock structure.
  *	@security pointer to the TUN device's security structure.
+ *	Return 0 if permission is granted.
  * @tun_dev_open:
  *	This hook can be used by the module to update any security state
  *	associated with the TUN device's security structure.
  *	@security pointer to the TUN devices's security structure.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for SCTP
  *
@@ -1063,6 +1091,7 @@
  *	to the security module.
  *	@asoc pointer to sctp association structure.
  *	@skb pointer to skbuff of association packet.
+ *	Return 0 on success, error on failure.
  *
  * Security hooks for Infiniband
  *
@@ -1071,15 +1100,17 @@
  *	@subnet_prefix the subnet prefix of the port being used.
  *	@pkey the pkey to be accessed.
  *	@sec pointer to a security structure.
+ *	Return 0 if permission is granted.
  * @ib_endport_manage_subnet:
  *	Check permissions to send and receive SMPs on a end port.
  *	@dev_name the IB device name (i.e. mlx4_0).
  *	@port_num the port number.
  *	@sec pointer to a security structure.
+ *	Return 0 if permission is granted.
  * @ib_alloc_security:
  *	Allocate a security structure for Infiniband objects.
  *	@sec pointer to a security structure pointer.
- *	Returns 0 on success, non-zero on failure
+ *	Returns 0 on success, non-zero on failure.
  * @ib_free_security:
  *	Deallocate an Infiniband security structure.
  *	@sec contains the security structure to be freed.
@@ -1107,6 +1138,7 @@
  * @xfrm_policy_delete_security:
  *	@ctx contains the xfrm_sec_ctx.
  *	Authorize deletion of xp->security.
+ *	Return 0 if permission is granted.
  * @xfrm_state_alloc:
  *	@x contains the xfrm_state being added to the Security Association
  *	Database by the XFRM system.
@@ -1132,6 +1164,7 @@
  * @xfrm_state_delete_security:
  *	@x contains the xfrm_state.
  *	Authorize deletion of x->security.
+ *	Return 0 if permission is granted.
  * @xfrm_policy_lookup:
  *	@ctx contains the xfrm_sec_ctx for which the access control is being
  *	checked.
@@ -1432,10 +1465,12 @@
  *	@secdata contains the pointer that stores the converted security
  *	context.
  *	@seclen pointer which contains the length of the data
+ *	Return 0 on success, error on failure.
  * @secctx_to_secid:
  *	Convert security context to secid.
  *	@secid contains the pointer to the generated security ID.
  *	@secdata contains the security context.
+ *	Return 0 on success, error on failure.
  *
  * @release_secctx:
  *	Release the security context.
@@ -1489,6 +1524,7 @@
  *	@inode we wish to set the security context of.
  *	@ctx contains the string which we wish to set in the inode.
  *	@ctxlen contains the length of @ctx.
+ *	Return 0 on success, error on failure.
  *
  * @inode_setsecctx:
  *	Change the security context of an inode.  Updates the
@@ -1502,6 +1538,7 @@
  *	@dentry contains the inode we wish to set the security context of.
  *	@ctx contains the string which we wish to set in the inode.
  *	@ctxlen contains the length of @ctx.
+ *	Return 0 on success, error on failure.
  *
  * @inode_getsecctx:
  *	On success, returns 0 and fills out @ctx and @ctxlen with the security
@@ -1509,6 +1546,7 @@
  *	@inode we wish to get the security context of.
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
+ *	Return 0 on success, error on failure.
  *
  * Security hooks for the general notification queue:
  *
@@ -1518,11 +1556,13 @@
  *	@w_cred: The credentials of the whoever set the watch.
  *	@cred: The event-triggerer's credentials
  *	@n: The notification being posted
+ *	Return 0 if permission is granted.
  *
  * @watch_key:
  *	Check to see if a process is allowed to watch for event notifications
  *	from a key or keyring.
  *	@key: The key to watch.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
@@ -1531,65 +1571,74 @@
  *	Do a initial check for all bpf syscalls after the attribute is copied
  *	into the kernel. The actual security module can implement their own
  *	rules to check the specific cmd they need.
+ *	Return 0 if permission is granted.
  *
  * @bpf_map:
  *	Do a check when the kernel generate and return a file descriptor for
  *	eBPF maps.
- *
- *	@map: bpf map that we want to access
- *	@mask: the access flags
+ *	@map: bpf map that we want to access.
+ *	@mask: the access flags.
+ *	Return 0 if permission is granted.
  *
  * @bpf_prog:
  *	Do a check when the kernel generate and return a file descriptor for
  *	eBPF programs.
- *
  *	@prog: bpf prog that userspace want to use.
+ *	Return 0 if permission is granted.
  *
  * @bpf_map_alloc_security:
  *	Initialize the security field inside bpf map.
+ *	Return 0 on success, error on failure.
  *
  * @bpf_map_free_security:
  *	Clean up the security information stored inside bpf map.
  *
  * @bpf_prog_alloc_security:
  *	Initialize the security field inside bpf program.
+ *	Return 0 on success, error on failure.
  *
  * @bpf_prog_free_security:
  *	Clean up the security information stored inside bpf prog.
  *
  * @locked_down:
- *     Determine whether a kernel feature that potentially enables arbitrary
- *     code execution in kernel space should be permitted.
- *
- *     @what: kernel feature being accessed
+ *	Determine whether a kernel feature that potentially enables arbitrary
+ *	code execution in kernel space should be permitted.
+ *	@what: kernel feature being accessed.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for perf events
  *
  * @perf_event_open:
- * 	Check whether the @type of perf_event_open syscall is allowed.
+ *	Check whether the @type of perf_event_open syscall is allowed.
+ *	Return 0 if permission is granted.
  * @perf_event_alloc:
- * 	Allocate and save perf_event security info.
+ *	Allocate and save perf_event security info.
+ *	Return 0 on success, error on failure.
  * @perf_event_free:
- * 	Release (free) perf_event security info.
+ *	Release (free) perf_event security info.
  * @perf_event_read:
- * 	Read perf_event security info if allowed.
+ *	Read perf_event security info if allowed.
+ *	Return 0 if permission is granted.
  * @perf_event_write:
- * 	Write perf_event security info if allowed.
+ *	Write perf_event security info if allowed.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for io_uring
  *
  * @uring_override_creds:
- *      Check if the current task, executing an io_uring operation, is allowed
- *      to override it's credentials with @new.
- *
- *      @new: the new creds to use
+ *	Check if the current task, executing an io_uring operation, is allowed
+ *	to override it's credentials with @new.
+ *	@new: the new creds to use.
+ *	Return 0 if permission is granted.
  *
  * @uring_sqpoll:
- *      Check whether the current task is allowed to spawn a io_uring polling
- *      thread (IORING_SETUP_SQPOLL).
+ *	Check whether the current task is allowed to spawn a io_uring polling
+ *	thread (IORING_SETUP_SQPOLL).
+ *	Return 0 if permission is granted.
  *
  * @uring_cmd:
- *      Check whether the file_operations uring_cmd is allowed to run.
+ *	Check whether the file_operations uring_cmd is allowed to run.
+ *	Return 0 if permission is granted.
  *
  */
 union security_list_options {
-- 
2.25.1

