Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539263AB65
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 15:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiK1Onh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 09:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiK1OnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 09:43:21 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20260B0B;
        Mon, 28 Nov 2022 06:43:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NLShy0NHgz9xGX3;
        Mon, 28 Nov 2022 22:36:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3oG3iyIRjL9qiAA--.42928S4;
        Mon, 28 Nov 2022 15:43:00 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     paul@paul-moore.com, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and fix formatting
Date:   Mon, 28 Nov 2022 15:42:40 +0100
Message-Id: <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3oG3iyIRjL9qiAA--.42928S4
X-Coremail-Antispam: 1UD129KBjvAXoWftFWDtryDJF1xWFykKF4rXwb_yoW5Ww1xXo
        WF9w42qw17Kr17CF4vk3s7Ga9xu3Z5uF48ArZYq3s0kFnaqryUWay3A3W7Xa13Ar48KFyD
        X34kAa40vF4Ut3Wfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYp7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        yl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfJ5rUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4H80gAAsS
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
values.

Also, replace spaces with tab for indentation, remove empty lines between
the hook description and the list of parameters, adjust semicolons and add
the period at the end of the parameter description.

Finally, move the description of gfp parameter of the
xfrm_policy_alloc_security hook together with the others.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hooks.h | 221 ++++++++++++++++++++++++--------------
 1 file changed, 138 insertions(+), 83 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c35e260efd8c..6502a1bea93a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -92,13 +92,17 @@
  *	is initialised to NULL by the caller.
  *	@fc indicates the new filesystem context.
  *	@src_fc indicates the original filesystem context.
+ *	Return 0 on success or a negative error code on failure.
  * @fs_context_parse_param:
  *	Userspace provided a parameter to configure a superblock.  The LSM may
  *	reject it with an error and may use it for itself, in which case it
  *	should return 0; otherwise it should return -ENOPARAM to pass it on to
  *	the filesystem.
  *	@fc indicates the filesystem context.
- *	@param The parameter
+ *	@param The parameter.
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
+ *	Return 0 on success, negative values on failure.
  * @sb_statfs:
  *	Check permission before obtaining filesystem statistics for the @mnt
  *	mountpoint.
@@ -139,19 +144,21 @@
  * @sb_mnt_opts_compat:
  *	Determine if the new mount options in @mnt_opts are allowed given
  *	the existing mounted filesystem at @sb.
- *	@sb superblock being compared
- *	@mnt_opts new mount options
+ *	@sb superblock being compared.
+ *	@mnt_opts new mount options.
  *	Return 0 if options are compatible.
  * @sb_remount:
  *	Extracts security system specific mount options and verifies no changes
  *	are being made to those options.
- *	@sb superblock being remounted
+ *	@sb superblock being remounted.
  *	@data contains the filesystem-specific data.
  *	Return 0 if permission is granted.
  * @sb_kern_mount:
- * 	Mount this @sb if allowed by permissions.
+ *	Mount this @sb if allowed by permissions.
+ *	Return 0 if permission is granted.
  * @sb_show_options:
  * 	Show (print on @m) mount options for this @sb.
+ *	Return 0 on success, negative values on failure.
  * @sb_umount:
  *	Check permission before the @mnt file system is unmounted.
  *	@mnt contains the mounted file system.
@@ -165,27 +172,31 @@
  *	Return 0 if permission is granted.
  * @sb_set_mnt_opts:
  *	Set the security relevant mount options used for a superblock
- *	@sb the superblock to set security mount options for
- *	@opts binary data structure containing all lsm mount data
+ *	@sb the superblock to set security mount options for.
+ *	@opts binary data structure containing all lsm mount data.
+ *	Return 0 on success, error on failure.
  * @sb_clone_mnt_opts:
  *	Copy all security options from a given superblock to another
- *	@oldsb old superblock which contain information to clone
- *	@newsb new superblock which needs filled in
+ *	@oldsb old superblock which contain information to clone.
+ *	@newsb new superblock which needs filled in.
+ *	Return 0 on success, error on failure.
  * @move_mount:
  *	Check permission before a mount is moved.
  *	@from_path indicates the mount that is going to be moved.
  *	@to_path indicates the mountpoint that will be mounted upon.
+ *	Return 0 if permission is granted.
  * @dentry_init_security:
  *	Compute a context for a dentry as the inode is not yet available
  *	since NFSv4 has no label backed by an EA anyway.
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file
+ *	@name name of the last path component used to create file.
  *	@xattr_name pointer to place the pointer to security xattr name.
  *		    Caller does not have to free the resulting pointer. Its
  *		    a pointer to static string.
  *	@ctx pointer to place the pointer to the resulting context in.
  *	@ctxlen point to place the length of the resulting context.
+ *	Return 0 on success, negative values on failure.
  * @dentry_create_files_as:
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
@@ -193,9 +204,10 @@
  *	passed in creds and not the creds of the caller.
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file
- *	@old creds which should be used for context calculation
- *	@new creds to modify
+ *	@name name of the last path component used to create file.
+ *	@old creds which should be used for context calculation.
+ *	@new creds to modify.
+ *	Return 0 on success, error on failure.
  *
  *
  * Security hooks for inode operations.
@@ -223,7 +235,7 @@
  *	then it should return -EOPNOTSUPP to skip this processing.
  *	@inode contains the inode structure of the newly created inode.
  *	@dir contains the inode structure of the parent directory.
- *	@qstr contains the last path component of the new object
+ *	@qstr contains the last path component of the new object.
  *	@name will be set to the allocated name suffix (e.g. selinux).
  *	@value will be set to the allocated attribute value.
  *	@len will be set to the length of the value.
@@ -234,9 +246,9 @@
  *      Set up the incore security field for the new anonymous inode
  *      and return whether the inode creation is permitted by the security
  *      module or not.
- *      @inode contains the inode structure
- *      @name name of the anonymous inode class
- *      @context_inode optional related inode
+ *      @inode contains the inode structure.
+ *      @name name of the anonymous inode class.
+ *      @context_inode optional related inode.
  *	Returns 0 on success, -EACCES if the security module denies the
  *	creation of this inode, or another -errno upon other errors.
  * @inode_create:
@@ -352,7 +364,7 @@
  *	mode is specified in @mode.
  *	@path contains the path structure of the file to change the mode.
  *	@mode contains the new DAC's permission, which is a bitmask of
- *	constants from <include/uapi/linux/stat.h>
+ *	constants from <include/uapi/linux/stat.h>.
  *	Return 0 if permission is granted.
  * @path_chown:
  *	Check for permission to change owner/group of a file or directory.
@@ -367,6 +379,7 @@
  * @path_notify:
  *	Check permissions before setting a watch on events as defined by @mask,
  *	on an object at @path, whose type is defined by @obj_type.
+ *	Return 0 if permission is granted.
  * @inode_readlink:
  *	Check the permission to read the symbolic link.
  *	@dentry contains the dentry structure for the file link.
@@ -374,7 +387,7 @@
  * @inode_follow_link:
  *	Check permission to follow a symbolic link when looking up a pathname.
  *	@dentry contains the dentry structure for the link.
- *	@inode contains the inode, which itself is not stable in RCU-walk
+ *	@inode contains the inode, which itself is not stable in RCU-walk.
  *	@rcu indicates whether we are in RCU-walk mode.
  *	Return 0 if permission is granted.
  * @inode_permission:
@@ -426,9 +439,9 @@
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
@@ -451,7 +464,7 @@
  * @inode_killpriv:
  *	The setuid bit is being removed.  Remove similar security labels.
  *	Called with the dentry->d_inode->i_mutex held.
- *	@mnt_userns: user namespace of the mount
+ *	@mnt_userns: user namespace of the mount.
  *	@dentry is the dentry being changed.
  *	Return 0 on success.  If error is returned, then the operation
  *	causing setuid bit removal is failed.
@@ -478,20 +491,22 @@
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
- *	@kn_dir the parent kernfs node
- *	@kn the new child kernfs node
+ *	@kn_dir the parent kernfs node.
+ *	@kn the new child kernfs node.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for file operations
  *
@@ -530,11 +545,11 @@
  *	simple integer value.  When @arg represents a user space pointer, it
  *	should never be used by the security module.
  *	Return 0 if permission is granted.
- * @mmap_addr :
+ * @mmap_addr:
  *	Check permissions for a mmap operation at @addr.
  *	@addr contains virtual address that will be used for the operation.
  *	Return 0 if permission is granted.
- * @mmap_file :
+ * @mmap_file:
  *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
  *	if mapping anonymous memory.
  *	@file contains the file structure for file to map (may be NULL).
@@ -589,6 +604,7 @@
  *	Save open-time permission checking state for later use upon
  *	file_permission, and recheck access if anything has changed
  *	since inode_permission.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for task operations.
  *
@@ -606,6 +622,7 @@
  *	@gfp indicates the atomicity of any memory allocations.
  *	Only allocate sufficient memory and attach to @cred such that
  *	cred_transfer() will not get ENOMEM.
+ *	Return 0 on success, negative values on failure.
  * @cred_free:
  *	@cred points to the credentials.
  *	Deallocate and clear the cred->security field in a set of credentials.
@@ -614,6 +631,7 @@
  *	@old points to the original credentials.
  *	@gfp indicates the atomicity of any memory allocations.
  *	Prepare a new set of credentials by copying the data from the old set.
+ *	Return 0 on success, negative values on failure.
  * @cred_transfer:
  *	@new points to the new credentials.
  *	@old points to the original credentials.
@@ -625,7 +643,7 @@
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
  *	@new points to the credentials to be modified.
- *	@secid specifies the security ID to be set
+ *	@secid specifies the security ID to be set.
  *	The current task must be the one that nominated @secid.
  *	Return 0 if successful.
  * @kernel_create_files_as:
@@ -638,19 +656,19 @@
  * @kernel_module_request:
  *	Ability to trigger the kernel to automatically upcall to userspace for
  *	userspace to load a kernel module with the given name.
- *	@kmod_name name of the module requested by the kernel
+ *	@kmod_name name of the module requested by the kernel.
  *	Return 0 if successful.
  * @kernel_load_data:
  *	Load data provided by userspace.
- *	@id kernel load data identifier
+ *	@id kernel load data identifier.
  *	@contents if a subsequent @kernel_post_load_data will be called.
  *	Return 0 if permission is granted.
  * @kernel_post_load_data:
  *	Load data provided by a non-file source (usually userspace buffer).
  *	@buf pointer to buffer containing the data contents.
  *	@size length of the data contents.
- *	@id kernel load data identifier
- *	@description a text description of what was loaded, @id-specific
+ *	@id kernel load data identifier.
+ *	@description a text description of what was loaded, @id-specific.
  *	Return 0 if permission is granted.
  *	This must be paired with a prior @kernel_load_data call that had
  *	@contents set to true.
@@ -658,7 +676,7 @@
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
  *	by the kernel.
- *	@id kernel read file identifier
+ *	@id kernel read file identifier.
  *	@contents if a subsequent @kernel_post_read_file will be called.
  *	Return 0 if permission is granted.
  * @kernel_post_read_file:
@@ -667,7 +685,7 @@
  *	by the kernel.
  *	@buf pointer to buffer containing the file contents.
  *	@size length of the file contents.
- *	@id kernel read file identifier
+ *	@id kernel read file identifier.
  *	This must be paired with a prior @kernel_read_file call that had
  *	@contents set to true.
  *	Return 0 if permission is granted.
@@ -677,7 +695,7 @@
  *	indicates which of the set*uid system calls invoked this hook.  If
  *	@new is the set of credentials that will be installed.  Modifications
  *	should be made to this rather than to @current->cred.
- *	@old is the set of credentials that are being replaces
+ *	@old is the set of credentials that are being replaces.
  *	@flags contains one of the LSM_SETID_* values.
  *	Return 0 on success.
  * @task_fix_setgid:
@@ -729,7 +747,7 @@
  * @task_setioprio:
  *	Check permission before setting the ioprio value of @p to @ioprio.
  *	@p contains the task_struct of process.
- *	@ioprio contains the new ioprio value
+ *	@ioprio contains the new ioprio value.
  *	Return 0 if permission is granted.
  * @task_getioprio:
  *	Check permission before getting the ioprio value of @p.
@@ -860,6 +878,7 @@
  *	@type contains the requested communications type.
  *	@protocol contains the requested protocol.
  *	@kern set to 1 if a kernel socket.
+ *	Return 0 if permission is granted.
  * @socket_socketpair:
  *	Check permissions before creating a fresh pair of sockets.
  *	@socka contains the first socket structure.
@@ -943,6 +962,7 @@
  *	Must not sleep inside this hook because some callers hold spinlocks.
  *	@sk contains the sock (not socket) associated with the incoming sk_buff.
  *	@skb contains the incoming network data.
+ *	Return 0 if permission is granted.
  * @socket_getpeersec_stream:
  *	This hook allows the security module to provide peer socket security
  *	state for unix or connected tcp sockets to userspace via getsockopt
@@ -970,6 +990,7 @@
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
  *	which is used to copy security attributes between local stream sockets.
+ *	Return 0 on success, error on failure.
  * @sk_free_security:
  *	Deallocate security structure.
  * @sk_clone_security:
@@ -982,17 +1003,19 @@
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
@@ -1003,21 +1026,25 @@
  * @tun_dev_free_security:
  *	This hook allows a module to free the security structure for a TUN
  *	device.
- *	@security pointer to the TUN device's security structure
+ *	@security pointer to the TUN device's security structure.
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
@@ -1050,6 +1077,7 @@
  *	to the security module.
  *	@asoc pointer to sctp association structure.
  *	@skb pointer to skbuff of association packet.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for Infiniband
  *
@@ -1058,15 +1086,17 @@
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
@@ -1078,10 +1108,11 @@
  *	Database used by the XFRM system.
  *	@sec_ctx contains the security context information being provided by
  *	the user-level policy update program (e.g., setkey).
+ *	@gfp is to specify the context for the allocation.
  *	Allocate a security structure to the xp->security field; the security
  *	field is initialized to NULL when the xfrm_policy is allocated.
- *	Return 0 if operation was successful (memory to allocate, legal context)
- *	@gfp is to specify the context for the allocation
+ *	Return 0 if operation was successful (memory to allocate, legal
+ *	context).
  * @xfrm_policy_clone_security:
  *	@old_ctx contains an existing xfrm_sec_ctx.
  *	@new_ctxp contains a new xfrm_sec_ctx being cloned from old.
@@ -1089,11 +1120,12 @@
  *	information from the old_ctx structure.
  *	Return 0 if operation was successful (memory to allocate).
  * @xfrm_policy_free_security:
- *	@ctx contains the xfrm_sec_ctx
+ *	@ctx contains the xfrm_sec_ctx.
  *	Deallocate xp->security.
  * @xfrm_policy_delete_security:
  *	@ctx contains the xfrm_sec_ctx.
  *	Authorize deletion of xp->security.
+ *	Return 0 if permission is granted.
  * @xfrm_state_alloc:
  *	@x contains the xfrm_state being added to the Security Association
  *	Database by the XFRM system.
@@ -1119,6 +1151,7 @@
  * @xfrm_state_delete_security:
  *	@x contains the xfrm_state.
  *	Authorize deletion of x->security.
+ *	Return 0 if permission is granted.
  * @xfrm_policy_lookup:
  *	@ctx contains the xfrm_sec_ctx for which the access control is being
  *	checked.
@@ -1147,7 +1180,7 @@
  *	Permit allocation of a key and assign security data. Note that key does
  *	not have a serial number assigned at this point.
  *	@key points to the key.
- *	@flags is the allocation flags
+ *	@flags is the allocation flags.
  *	Return 0 if permission is granted, -ve error otherwise.
  * @key_free:
  *	Notification of destruction; free security data.
@@ -1177,8 +1210,8 @@
  *
  * @ipc_permission:
  *	Check permissions for access to IPC
- *	@ipcp contains the kernel IPC permission structure
- *	@flag contains the desired (requested) permission set
+ *	@ipcp contains the kernel IPC permission structure.
+ *	@flag contains the desired (requested) permission set.
  *	Return 0 if permission is granted.
  * @ipc_getsecid:
  *	Get the secid associated with the ipc object.
@@ -1323,15 +1356,18 @@
  *	to @to.
  *	@from contains the struct cred for the sending process.
  *	@to contains the struct cred for the receiving process.
+ *	Return 0 if permission is granted.
  * @binder_transfer_binder:
  *	Check whether @from is allowed to transfer a binder reference to @to.
  *	@from contains the struct cred for the sending process.
  *	@to contains the struct cred for the receiving process.
+ *	Return 0 if permission is granted.
  * @binder_transfer_file:
  *	Check whether @from is allowed to transfer @file to @to.
  *	@from contains the struct cred for the sending process.
  *	@file contains the struct file being transferred.
  *	@to contains the struct cred for the receiving process.
+ *	Return 0 if permission is granted.
  *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
@@ -1373,26 +1409,29 @@
  *	Check whether the @tsk process has the @cap capability in the indicated
  *	credentials.
  *	@cred contains the credentials to use.
- *	@ns contains the user namespace we want the capability in
+ *	@ns contains the user namespace we want the capability in.
  *	@cap contains the capability <include/linux/capability.h>.
- *	@opts contains options for the capable check <include/linux/security.h>
+ *	@opts contains options for the capable check <include/linux/security.h>.
  *	Return 0 if the capability is granted for @tsk.
  * @quotactl:
- * 	Check whether the quotactl syscall is allowed for this @sb.
+ *	Check whether the quotactl syscall is allowed for this @sb.
+ *	Return 0 if permission is granted.
  * @quota_on:
- * 	Check whether QUOTAON is allowed for this @dentry.
+ *	Check whether QUOTAON is allowed for this @dentry.
+ *	Return 0 if permission is granted.
  * @syslog:
  *	Check permission before accessing the kernel message ring or changing
  *	logging to the console.
  *	See the syslog(2) manual page for an explanation of the @type values.
- *	@type contains the SYSLOG_ACTION_* constant from <include/linux/syslog.h>
+ *	@type contains the SYSLOG_ACTION_* constant from
+ *	<include/linux/syslog.h>.
  *	Return 0 if permission is granted.
  * @settime:
  *	Check permission to change the system time.
  *	struct timespec64 is defined in <include/linux/time64.h> and timezone
  *	is defined in <include/linux/time.h>
- *	@ts contains new time
- *	@tz contains new timezone
+ *	@ts contains new time.
+ *	@tz contains new timezone.
  *	Return 0 if permission is granted.
  * @vm_enough_memory:
  *	Check permissions for allocating a new virtual mapping.
@@ -1420,11 +1459,13 @@
  *	@secid contains the security ID.
  *	@secdata contains the pointer that stores the converted security
  *	context.
- *	@seclen pointer which contains the length of the data
+ *	@seclen pointer which contains the length of the data.
+ *	Return 0 on success, error on failure.
  * @secctx_to_secid:
  *	Convert security context to secid.
  *	@secid contains the pointer to the generated security ID.
  *	@secdata contains the security context.
+ *	Return 0 on success, error on failure.
  *
  * @release_secctx:
  *	Release the security context.
@@ -1461,7 +1502,7 @@
  * @audit_rule_free:
  *	Deallocate the LSM audit rule structure previously allocated by
  *	audit_rule_init.
- *	@lsmrule contains the allocated rule
+ *	@lsmrule contains the allocated rule.
  *
  * @inode_invalidate_secctx:
  *	Notify the security module that it must revalidate the security context
@@ -1478,6 +1519,7 @@
  *	@inode we wish to set the security context of.
  *	@ctx contains the string which we wish to set in the inode.
  *	@ctxlen contains the length of @ctx.
+ *	Return 0 on success, error on failure.
  *
  * @inode_setsecctx:
  *	Change the security context of an inode.  Updates the
@@ -1491,6 +1533,7 @@
  *	@dentry contains the inode we wish to set the security context of.
  *	@ctx contains the string which we wish to set in the inode.
  *	@ctxlen contains the length of @ctx.
+ *	Return 0 on success, error on failure.
  *
  * @inode_getsecctx:
  *	On success, returns 0 and fills out @ctx and @ctxlen with the security
@@ -1498,6 +1541,7 @@
  *	@inode we wish to get the security context of.
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
+ *	Return 0 on success, error on failure.
  *
  * Security hooks for the general notification queue:
  *
@@ -1505,13 +1549,15 @@
  *	Check to see if a watch notification can be posted to a particular
  *	queue.
  *	@w_cred: The credentials of the whoever set the watch.
- *	@cred: The event-triggerer's credentials
- *	@n: The notification being posted
+ *	@cred: The event-triggerer's credentials.
+ *	@n: The notification being posted.
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
@@ -1520,65 +1566,74 @@
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

